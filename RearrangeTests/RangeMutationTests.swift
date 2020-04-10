//
//  RangeMutationTests.swift
//  TextProcessingTests
//
//  Created by Matt Massicotte on 12/24/17.
//  Copyright © 2017 Chime Systems Inc. All rights reserved.
//

import XCTest
@testable import Rearrange

class RangeMutationTests: XCTestCase {
    // MARK: location transformations
    func testMutationBeforeLocation() {
        let change = RangeMutation(range: NSMakeRange(0, 1), delta: 1, limit: 15)

        XCTAssertEqual(change.transform(location: 10), 11)
    }

    func testMutationBeforeLimitLocation() {
        let change = RangeMutation(range: NSMakeRange(0, 1), delta: 1, limit: 15)

        XCTAssertEqual(change.transform(location: 14), 15)
    }

    func testMutationAtLimitLocation() {
        let change = RangeMutation(range: NSRange(5..<5), delta: 1, limit: 5)

        XCTAssertEqual(change.transform(location: 5), 6)
    }

    func testMutationAfterLocation() {
        let change = RangeMutation(range: NSMakeRange(11, 1), delta: 1, limit: 15)

        XCTAssertEqual(change.transform(location: 10), 10)
    }

    func testMutationStartingAtLocation() {
        let change = RangeMutation(range: NSMakeRange(10, 1), delta: 1, limit: 15)

        XCTAssertEqual(change.transform(location: 10), 10)
    }

    func testMutationStartingAtLocationWithNoDelta() {
        let change = RangeMutation(range: NSMakeRange(10, 1), delta: 0, limit: 15)

        XCTAssertEqual(change.transform(location: 10), 10)
    }

    func testMutationEndingAtLocation() {
        let change = RangeMutation(range: NSMakeRange(9, 1), delta: 1, limit: 15)

        XCTAssertEqual(change.transform(location: 10), 11)
    }

    func testMutationRemovesLocation() {
        let change = RangeMutation(range: NSMakeRange(0, 5), delta: -5, limit: 15)

        XCTAssertEqual(change.transform(location: 2), nil)
    }

    func testMutationAtEndingRemovesLocation() {
        let change = RangeMutation(range: NSMakeRange(0, 5), delta: -5, limit: 15)

        XCTAssertEqual(change.transform(location: 5), 0)
    }

    func testMutationAtBeginningRemovesLocation() {
        let change = RangeMutation(range: NSMakeRange(0, 5), delta: -5, limit: 15)

        XCTAssertEqual(change.transform(location: 0), 0)
    }

    func testMutationWithZeroLengthBeforeLocation() {
        let change = RangeMutation(range: NSMakeRange(5, 0), delta: 5, limit: 15)

        XCTAssertEqual(change.transform(location: 10), 15)
    }

    // MARK: range transformations
    func testMutationAfterRange() {
        let change = RangeMutation(range: NSMakeRange(10, 1), delta: -1, limit: 11)

        XCTAssertEqual(change.transform(range: NSMakeRange(0, 5)), NSMakeRange(0, 5))
    }

    func testMutationRemovalAtEndingOfRange() {
        let change = RangeMutation(range: NSMakeRange(5, 1), delta: -1, limit: 11)

        XCTAssertEqual(change.transform(range: NSMakeRange(0, 5)), NSMakeRange(0, 5))
    }

    func testMutationRemovalOfEndingOfRange() {
        let change = RangeMutation(range: NSMakeRange(4, 1), delta: -1, limit: 10)

        XCTAssertEqual(change.transform(range: NSMakeRange(0, 5)), NSMakeRange(0, 4))
    }

    func testMutationAdditionAtEndingOfRange() {
        let change = RangeMutation(range: NSMakeRange(5, 0), delta: 1, limit: 11)

        XCTAssertEqual(change.transform(range: NSMakeRange(0, 5)), NSMakeRange(0, 5))
    }

    func testMutationAtBeginningRange() {
        let change = RangeMutation(range: NSMakeRange(1, 5), delta: -5, limit: 10)

        XCTAssertEqual(change.transform(range: NSMakeRange(0, 1)), NSMakeRange(0, 1))
        XCTAssertEqual(change.transform(range: NSMakeRange(1, 0)), NSMakeRange(1, 0))
    }

    func testMutationAtZeroRange() {
        let change = RangeMutation(range: NSMakeRange(0, 0), delta: 5, limit: 10)

        XCTAssertEqual(change.transform(range: NSMakeRange(0, 5)), NSMakeRange(5, 5))
        XCTAssertEqual(change.transform(range: NSMakeRange(0, 0)), NSMakeRange(0, 0))
    }

    func testMutationAtBeginning() {
        let change = RangeMutation(range: NSMakeRange(5, 1), delta: -1, limit: 12)

        XCTAssertEqual(change.transform(range: NSMakeRange(10, 2)), NSMakeRange(9, 2))
    }

    func testMutationIncreasesLengthOfRange() {
        let change = RangeMutation(range: NSMakeRange(5, 0), delta: 1, limit: 11)

        XCTAssertEqual(change.transform(range: NSMakeRange(0, 10)), NSMakeRange(0, 11))
    }

    func testMutationDecreasesLengthOfRange() {
        let change = RangeMutation(range: NSMakeRange(5, 1), delta: -1, limit: 10)

        XCTAssertEqual(change.transform(range: NSMakeRange(0, 10)), NSMakeRange(0, 9))
    }

    func testMutationRemovesEntireRange() {
        let change = RangeMutation(range: NSMakeRange(0, 5), delta: -5, limit: 10)

        XCTAssertNil(change.transform(range: NSMakeRange(1, 2)))
        XCTAssertNil(change.transform(range: NSMakeRange(1, 4)))
        XCTAssertNil(change.transform(range: NSMakeRange(4, 1)))
    }

    func testMutationRemovesExactRange() {
        let change = RangeMutation(range: NSRange(5..<10), delta: -5, limit: 10)

        XCTAssertEqual(change.transform(range: NSRange(5..<10)), NSRange(5..<5))
    }

    func testMutationReplaceExactRange() {
        let change = RangeMutation(range: NSRange(5..<10), delta: 0, limit: 10)

        XCTAssertEqual(change.transform(range: NSRange(5..<10)), NSRange(5..<5))
    }
}
