//
//  NSRange+ApplyMutation.swift
//  Edit
//
//  Created by Matt Massicotte on 2019-06-20.
//  Copyright © 2019 Chime Systems. All rights reserved.
//

import Foundation

extension NSRange {
    public func apply(_ change: RangeMutation) -> NSRange? {
        // a trivial case
        if change.delta == 0 {
            return self
        }

        // past, nothing to do
        if change.range.location > max {
            return self
        }

        // in front of us, shift
        if change.range.max <= location {
            guard let new = shifted(by: change.delta) else {
                fatalError("change makes range invalid")
            }

            precondition(new.max <= change.limit)

            return new
        }

        if change.range.location == max && length != 0 {
            return self
        }

        // range has to be expanded, or possibly completely removed
        return shifted(endBy: change.delta)
    }
}

