//
//  IndexSet+NSRange.swift
//  Edit
//
//  Created by Matt Massicotte on 2018-10-18.
//  Copyright © 2018 Chime Systems Inc. All rights reserved.
//

import Foundation

public extension IndexSet {
    mutating func insert(range: NSRange) {
        insert(integersIn: Range<IndexSet.Element>(range)!)
    }

    mutating func insert(ranges: [NSRange]) {
        ranges.forEach { insert(range: $0) }
    }

    var nsRangeView: [NSRange] {
        return rangeView.map { NSRange($0) }
    }
}
