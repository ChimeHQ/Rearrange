//
//  NSRange+Shift.swift
//  Rearrange
//
//  Created by Matt Massicotte on 2019-06-20.
//  Copyright © 2019 Chime Systems Inc. All rights reserved.
//

import Foundation

extension NSRange {
    /// Returns an NSRange offset by a delta
    ///
    /// This function returns a new NSRange, with the location offset
    /// by delta. Conceptually, this is like sliding the receiver.
    ///
    /// If the location + delta would result in a negative number,
    /// this returns nil.
    public func shifted(by delta: Int) -> NSRange? {
        let newLocation = location + delta

        if newLocation < 0 {
            return nil
        }

        return NSRange(location: newLocation, length: length)
    }

    /// Returns an NSRange shifted by location
    ///
    /// This function shifts the starting location by delta,
    /// and adjusts the corresponding length. This operation
    /// affects only the starting location. The result will
    /// have the same ending position.
    ///
    /// If the resulting length or location would be negative,
    /// or if the delta is larger than the length this returns nil.
    public func shifted(startBy delta: Int) -> NSRange? {
        let newLocation = location + delta
        let newLength = length - delta

        if newLocation < 0 || newLength < 0 {
            return nil
        }

        return NSRange(location: newLocation, length: newLength)
    }

    /// Returns an NSRange shifted by length
    ///
    /// This function shifts the length by delta. This operation
    /// affects only the ending position. The result will
    /// have the same location.
    ///
    /// If the resulting length would be negative,
    /// this returns nil.
    public func shifted(endBy delta: Int) -> NSRange? {
        let newLength = length + delta

        if newLength < 0 {
            return nil
        }

        return NSRange(location: location, length: newLength)
    }
}
