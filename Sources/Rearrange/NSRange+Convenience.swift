//
//  NSRange+Convenience.swift
//  Rearrange
//
//  Created by Matt Massicotte on 2019-06-20.
//  Copyright © 2019 Chime Systems Inc. All rights reserved.
//

import Foundation

extension NSRange {
    public static let zero = NSRange(location: 0, length: 0)
    public static let notFound = NSRange(location: NSNotFound, length: 0)
}

extension NSRange {
    public var max: Int {
        return NSMaxRange(self)
    }
}

extension NSRange: Sequence {
    public typealias Element = Range<Int>.Element
    public typealias Iterator = Range<Int>.Iterator

    public func makeIterator() -> Range<Int>.Iterator {
        return (location..<NSMaxRange(self)).makeIterator()
    }
}

extension NSRange {
	public init<Calculator: TextRangeCalculating>(_ textRange: Calculator.TextRange, with calculator: Calculator) {
		let location = calculator.offset(from: calculator.beginningOfDocument, to: textRange.lowerBound)
		let length = calculator.offset(from: textRange.lowerBound, to: textRange.upperBound)

		self.init(location: location, length: length)
	}
}
