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

        precondition(range.length + delta >= 0, "delta must not be cause range length to go negative")
    }

    public init(stringContents string: String) {
        let length = string.utf16.count

        self.init(range: NSRange.zero, delta: length, limit: 0)
    }

    public var limit: Int {
        return presetLimit ?? range.max
    }

    public var postApplyLimit: Int {
        return limit + delta
    }
}

extension RangeMutation {
    public func transform(location: Int) -> Int? {
        if range.location > location {
            return location
        }

        // this is a funny case that was hard to get right,
        // related to boundary conditions
        if range.location == location && range.length > 0 {
            return location
        }

        if range.max <= location {
            let result = location + delta

            precondition(result >= 0)

            if let l = presetLimit {
                precondition(result <= l)
            }

            return result
        }

        return nil
    }
}

extension RangeMutation {
    public func transform(range r: NSRange) -> NSRange? {
        // This is a gross special-case that I'd prefer to avoid. But,
        // I'm strugging to come up with logic that makes sense for this
        // otherwise.
        if range.location == r.max && delta > 0 && range.location != 0 {
            return r
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
}
