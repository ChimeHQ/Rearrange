//
//  IndexSet+NSRange.swift
//  Edit
//
//  Created by Matt Massicotte on 2018-10-18.
//  Copyright © 2018 Chime Systems Inc. All rights reserved.
//

import Foundation

public extension IndexSet {
    init(integersIn range: NSRange) {
        self.init(integersIn: Range<IndexSet.Element>(range)!)
    }

    mutating func insert(range: NSRange) {
        insert(integersIn: Range<IndexSet.Element>(range)!)
    }

    mutating func insert(ranges: [NSRange]) {
        ranges.forEach { insert(range: $0) }
    }

    mutating func remove(integersIn range: NSRange) {
        guard let rng = Range<IndexSet.Element>(range) else {
            fatalError("Range could not be computed from \(range)")
        }

        remove(integersIn: rng)
    }

    var nsRangeView: [NSRange] {
        return rangeView.map { NSRange($0) }
    }

    /// Returns true if entire range is contained
    func contains(integersIn range: NSRange) -> Bool {
        guard let elementRange = Range<IndexSet.Element>(range) else {
            return false
        }

        return contains(integersIn: elementRange)
    }

    /// Returns true if at least one location in range is contained
    func intersects(integersIn range : NSRange) -> Bool {
        guard let elementRange = Range<IndexSet.Element>(range) else {
            return false
        }

        return intersects(integersIn: elementRange)
    }

    /// Returns a range encompassing the minimum and maximum value of the set.
    ///
    /// The resulting range includes both minimum and maximum boundaries of `self` because these describe indices that should be part of the range, not past-end positions.
    ///
    /// This value will be nil if either `min()` or `max()` are `nil`.
    var limitSpanningRange: NSRange? {
        guard let start = self.min(), let end = self.max() else {
            return nil
        }

        return NSRange(start...end)
    }
}
