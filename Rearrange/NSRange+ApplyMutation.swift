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
        if location == NSNotFound {
            return nil
        }
        
        if change.presetLimit != nil {
            precondition(change.range.max <= change.limit)
        }

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

            if change.presetLimit != nil {
                precondition(new.max <= change.postApplyLimit)
            }

            return new
        }

        if change.range.location == max && length != 0 {
            return self
        }

        // range has to be expanded, or possibly completely removed
        return shifted(endBy: change.delta)
    }
}

