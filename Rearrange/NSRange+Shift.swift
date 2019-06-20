//
//  NSRange+Shift.swift
//  Rearrange
//
//  Created by Matt Massicotte on 2019-06-20.
//  Copyright © 2019 Chime Systems Inc. All rights reserved.
//

import Foundation

extension NSRange {
    public func shifted(by delta: Int) -> NSRange? {
        if (delta < 0 && labs(delta) > location) {
            return nil
        }

        return NSMakeRange(location + delta, length)
    }

    public func shifted(startBy delta: Int) -> NSRange? {
        if delta > length {
            return nil
        }

        if (delta < 0 && labs(delta) > location) {
            return nil
        }

        return NSMakeRange(location + delta, length - delta)
    }

    public func shifted(endBy delta: Int) -> NSRange? {
        if (delta < 0 && labs(delta) > length) {
            return nil
        }

        return NSMakeRange(location, length + delta)
    }
}
