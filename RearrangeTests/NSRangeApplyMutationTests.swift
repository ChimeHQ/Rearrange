//
//  NSRangeApplyMutationTests.swift
//  TextProcessingTests
//
//  Created by Matt Massicotte on 12/12/17.
//  Copyright © 2017 Chime Systems Inc. All rights reserved.
//

import XCTest
@testable import Rearrange

class NSRangeApplyMutationTests: XCTestCase {
    func testApplyTextChangeRightAtLimit() {
        let range = NSMakeRange(10, 2)

        let change = RangeMutation(range: NSMakeRange(5, 1), delta: -1, limit: 11)

        XCTAssertEqual(range.apply(change), NSMakeRange(9, 2))
    }

    func testApplyTextChangeAtUpperBoundary() {
        let range = NSMakeRange(0, 5)

        let change = RangeMutation(range: NSMakeRange(5, 1), delta: -1, limit: 11)

        XCTAssertEqual(range.apply(change), NSMakeRange(0, 5))
    }

    func testApplyTextChangeAfter() {
        let range = NSMakeRange(0, 5)

        let change = RangeMutation(range: NSMakeRange(10, 1), delta: -1, limit: 11)

        XCTAssertEqual(range.apply(change), NSMakeRange(0, 5))
    }

    func testApplyTextChangeAtZero() {
        let range = NSMakeRange(0, 5)

        let change = RangeMutation(range: NSMakeRange(0, 0), delta: 5, limit: 10)

        XCTAssertEqual(range.apply(change), NSMakeRange(5, 5))
    }

    func testApplyTextChangeAtZeroWithZeroLength() {
        let range = NSMakeRange(0, 0)

        let change = RangeMutation(range: NSMakeRange(0, 0), delta: 5, limit: 10)

        XCTAssertEqual(range.apply(change), NSMakeRange(5, 0))
    }

    func testApplyTextChangeRemovingAtZeroWithZeroLength() {
        let range = NSMakeRange(0, 0)

        let change = RangeMutation(range: NSMakeRange(0, 5), delta: -5, limit: 10)

        XCTAssertEqual(range.apply(change), nil)
    }

    func testApplyTextChangeAfterWithZeroLength() {
        let range = NSMakeRange(0, 0)

        let change = RangeMutation(range: NSMakeRange(5, 0), delta: 5, limit: 10)

        XCTAssertEqual(range.apply(change), NSMakeRange(0, 0))
    }

    func testApplyTextChangeExpandingWithin() {
        let range = NSMakeRange(0, 10)

        let change = RangeMutation(range: NSMakeRange(5, 0), delta: 1, limit: 11)

        XCTAssertEqual(range.apply(change), NSMakeRange(0, 11))
    }

    func testApplyTextChangeRemovingWithin() {
        let range = NSMakeRange(0, 10)

        let change = RangeMutation(range: NSMakeRange(5, 2), delta: -2, limit: 10)

        XCTAssertEqual(range.apply(change), NSMakeRange(0, 8))
    }

    func testApplyTextChangeRemovingEntireRange() {
        let range = NSMakeRange(2, 4)

        let change = RangeMutation(range: NSMakeRange(0, 10), delta: -10)

        XCTAssertEqual(range.apply(change), nil)
    }

    func testApplyTextChangeRemovingEntireRangeZeroLength() {
        let range = NSMakeRange(2, 0)

        let change = RangeMutation(range: NSMakeRange(0, 10), delta: -10)

        XCTAssertEqual(range.apply(change), nil)
    }

    func testApplyTextChangeMakingRangeZero() {
        let range = NSMakeRange(0, 10)

        let change = RangeMutation(range: NSMakeRange(0, 10), delta: -10, limit: 10)

        XCTAssertEqual(range.apply(change), NSMakeRange(0, 0))
    }

    func testApplyTextChangeAtBeginning() {
        let range = NSMakeRange(5, 5)

        let change = RangeMutation(range: NSMakeRange(5, 0), delta: 1, limit: 11)

        XCTAssertEqual(range.apply(change), NSMakeRange(6, 5))
    }

    func testApplyTextChangeAtBeginningWithZeroLength() {
        let range = NSMakeRange(5, 0)

        let change = RangeMutation(range: NSMakeRange(5, 0), delta: 1, limit: 11)

        XCTAssertEqual(range.apply(change), NSMakeRange(6, 0))
    }
}
