//
//  NSRangeShiftTests.swift
//  RearrangeTests
//
//  Created by Matt Massicotte on 2019-11-09.
//  Copyright © 2019 Chime Systems Inc. All rights reserved.
//

import XCTest

class NSRangeShiftTests: XCTestCase {
    // MARK: shift(delta:)
    func testShiftedByZero() {
        let range = NSRange(location: 0, length: 5)

        XCTAssertEqual(range.shifted(by: 0), NSRange(location: 0, length: 5))
    }

    func testShiftedByValueMakingLocationZero() {
        let range = NSRange(location: 5, length: 5)

        XCTAssertEqual(range.shifted(by: -5), NSRange(location: 0, length: 5))
    }

    func testShiftedByValueMakingLocationNegative() {
        let range = NSRange(location: 0, length: 5)

        XCTAssertEqual(range.shifted(by: -1), nil)
    }

    // MARK: shift(startBy:)
    func testShiftedStartByZero() {
        let range = NSRange(location: 0, length: 5)

        XCTAssertEqual(range.shifted(startBy: 0), NSRange(location: 0, length: 5))
    }

    func testShiftedStartByLessThanLength() {
        let range = NSRange(location: 0, length: 5)

        XCTAssertEqual(range.shifted(startBy: 2), NSRange(location: 2, length: 3))
    }

    func testShiftedStartByLength() {
        let range = NSRange(location: 0, length: 5)

        XCTAssertEqual(range.shifted(startBy: 5), NSRange(location: 5, length: 0))
    }

    func testShiftedStartByGreaterThanLength() {
        let range = NSRange(location: 0, length: 5)

        XCTAssertEqual(range.shifted(startBy: 6), nil)
    }
}
