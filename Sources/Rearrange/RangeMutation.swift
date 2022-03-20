//
//  RangeMutation.swift
//  Rearrange
//
//  Created by Matt Massicotte on 2019-06-20.
//  Copyright © 2019 Chime Systems Inc. All rights reserved.
//

import Foundation

/// RangeMutation encapsulates a single change in a larger NSRange, like a text representation.
public struct RangeMutation {
    public let range: NSRange
    public let delta: Int
    let presetLimit: Int?

    public init(range: NSRange, delta: Int, limit: Int? = nil) {
        self.range = range
        self.delta = delta
        self.presetLimit = limit

        if let l = limit {
            precondition(l >= 0)
            precondition(range.max <= l, "range must not exceed limit")
        }

        precondition(range.length + delta >= 0, "delta must not cause range length to go negative")
    }

    public init(stringContents string: String) {
        let length = string.utf16.count

        self.init(range: NSRange.zero, delta: length, limit: 0)
    }

    public var limit: Int {
        return presetLimit ?? range.max
    }

    /// The range limit, with the delta applied
    public var postApplyLimit: Int {
        return limit + delta
    }

    /// Returns true if the mutating range overlaps the argument
    public func overlaps(_ r: NSRange) -> Bool {
        if r.location == NSNotFound {
            return false
        }
        
        if range.location >= r.max {
            return false
        }

        if range.max <= r.location {
            return false
        }

        return true
    }

    /// Returns true if the mutation may alter the argument,
    /// even if applying the mutation could result in it being unchanged
    public func affects(_ r: NSRange) -> Bool {
        if r.location == NSNotFound {
            return false
        }

        if r == .zero {
            return false
        }

        if overlaps(r) {
            return true
        }

        return range.max < r.max
    }
}

extension RangeMutation: Hashable {
}

extension RangeMutation {
    public func transform(location: Int) -> Int? {
        if let l = presetLimit {
            precondition(location <= l)
        }

        if range.location > location {
            return location
        }

        // this is a funny case that was hard to get right,
        // related to boundary conditions
        if range.location == location && range.length > 0 {
            return location
        }

        if range.max > location {
            return nil
        }

        let result = location + delta

        precondition(result >= 0)

        if presetLimit != nil {
            precondition(result <= postApplyLimit)
        }

        return result
    }
}

public extension RangeMutation {
     func transform(range r: NSRange) -> NSRange? {
        // This is a gross special-case that I'd prefer to avoid. But,
        // I'm strugging to come up with logic that makes sense for this
        // otherwise.
        if range.location == r.max && delta > 0 && range.location != 0 {
            return r
        }

        // Here's another special case, where both ranges are identical. This
        // means everything has changed, but the range location can remain.
        if range == r {
            return NSRange(location: range.location, length: 0)
        }

        guard let start = transform(location: r.location) else {
            return nil
        }

        guard let end = transform(location: r.max) else {
            return nil
        }

        if end < start {
            return nil
        }

        return NSMakeRange(start, end - start)
    }

    func transform(set: IndexSet) -> IndexSet {
        let ranges = set.nsRangeView

        let transformedRanges = ranges.compactMap({ transform(range: $0) })

        var newSet = IndexSet()

        newSet.insert(ranges: transformedRanges)

        return newSet
    }
}
