//
//  NSRange+Convenience.swift
//  Rearrange
//
//  Created by Matt Massicotte on 2019-06-20.
//  Copyright © 2019 Chime Systems Inc. All rights reserved.
//

import Foundation

extension NSRange {
    public static var zero = NSRange(location: 0, length: 0)
}

extension NSRange {
    public var max : Int {
        return NSMaxRange(self)
    }
}
