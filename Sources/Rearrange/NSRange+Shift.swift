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
        if location == NSNotFound {
            return nil
        }

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
        if location == NSNotFound {
            return nil
        }

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
        if location == NSNotFound {
            return nil
        }
        
        let newLength = length + delta

        if newLength < 0 {
            return nil
        }

        return NSRange(location: location, length: newLength)
    }

    /// Returns an NSRange that will not exceed a limit
    ///
    /// This functions ensures that the resulting range
    /// does not exceed the supplied limit. The result
    /// will have a location <= the limit, and may
    /// have zero length.
    public func clamped(to limit: Int) -> NSRange {
        if location == NSNotFound {
            return self
        }

        let start = Swift.min(location, limit)
        let end = Swift.min(max, limit)

        return NSRange(start..<end)
    }
}
