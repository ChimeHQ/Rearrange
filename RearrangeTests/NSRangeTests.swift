//
//  NSRangeTests.swift
//  RearrangeTests
//
//  Created by Matt Massicotte on 2020-04-16.
//  Copyright © 2020 Chime Systems Inc. All rights reserved.
//

import XCTest

class NSRangeTests: XCTestCase {
    func testRangeIterator() {
        let range = NSRange(location: 5, length: 5)

        var iterator = range.makeIterator()

        XCTAssertEqual(iterator.next(), 5)
        XCTAssertEqual(iterator.next(), 6)
        XCTAssertEqual(iterator.next(), 7)
        XCTAssertEqual(iterator.next(), 8)
        XCTAssertEqual(iterator.next(), 9)
        XCTAssertNil(iterator.next())
    }

    func testRangeInteratorWithInvalidValues() {
        var notFoundIterator = NSRange.notFound.makeIterator()

        XCTAssertNil(notFoundIterator.next())
    }

    func testClamped() {
        let range = NSRange(location: 10, length: 10)

        XCTAssertEqual(range.clamped(to: 30), NSRange(10..<20))
        XCTAssertEqual(range.clamped(to: 20), NSRange(10..<20))
        XCTAssertEqual(range.clamped(to: 19), NSRange(10..<19))
        XCTAssertEqual(range.clamped(to: 11), NSRange(10..<11))
        XCTAssertEqual(range.clamped(to: 10), NSRange(10..<10))
        XCTAssertEqual(range.clamped(to: 9), NSRange(9..<9))
        XCTAssertEqual(range.clamped(to: 0), NSRange(0..<0))
    }

    func testClampedWithInvalidValues() {
        XCTAssertEqual(NSRange.notFound.clamped(to: 0), NSRange.notFound)
    }
}
