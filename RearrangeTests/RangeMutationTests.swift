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
}

extension RangeMutationTests {
    // MARK: range transformations

    func testMutationAfterRange() {
        let change = RangeMutation(range: NSRange(10..<11), delta: -1, limit: 11)
        let range = NSRange(0..<5)

        XCTAssertFalse(change.affects(range))
        XCTAssertFalse(change.overlaps(range))
        XCTAssertEqual(change.transform(range: range), range)
    }

    func testMutationRemovalAtEndingOfRange() {
        let change = RangeMutation(range: NSRange(5..<6), delta: -1, limit: 11)
        let range = NSRange(0..<5)

        XCTAssertFalse(change.affects(range))
        XCTAssertFalse(change.overlaps(range))
        XCTAssertEqual(change.transform(range: range), range)
    }

    func testMutationRemovalOfEndingOfRange() {
        let change = RangeMutation(range: NSRange(4..<5), delta: -1, limit: 10)
        let range = NSRange(0..<5)

        XCTAssertTrue(change.affects(range))
        XCTAssertTrue(change.overlaps(range))
        XCTAssertEqual(change.transform(range: range), NSRange(0..<4))
    }

    func testMutationAdditionAtEndingOfRange() {
        let change = RangeMutation(range: NSRange(5..<5), delta: 1, limit: 11)
        let range = NSRange(0..<5)

        XCTAssertFalse(change.affects(range))
        XCTAssertFalse(change.overlaps(range))
        XCTAssertEqual(change.transform(range: range), range)
    }

    func testMutationAtBeginningRange() {
        let change = RangeMutation(range: NSRange(1..<6), delta: -5, limit: 10)
        let rangeA = NSRange(0..<1)

        XCTAssertFalse(change.affects(rangeA))
        XCTAssertFalse(change.overlaps(rangeA))
        XCTAssertEqual(change.transform(range: rangeA), rangeA)

        let rangeB = NSRange(1..<1)

        XCTAssertFalse(change.affects(rangeB))
        XCTAssertFalse(change.overlaps(rangeB))
        XCTAssertEqual(change.transform(range: rangeB), rangeB)
    }

    func testMutationAtZeroRange() {
        let change = RangeMutation(range: .zero, delta: 5, limit: 10)
        let range = NSRange(0..<5)

        XCTAssertTrue(change.affects(range))
        XCTAssertFalse(change.overlaps(range))
        XCTAssertEqual(change.transform(range: range), NSRange(5..<10))

        XCTAssertFalse(change.affects(.zero))
        XCTAssertFalse(change.overlaps(.zero))
        XCTAssertEqual(change.transform(range: .zero), .zero)
    }

    func testMutationAtBeginning() {
        let change = RangeMutation(range: NSRange(5..<6), delta: -1, limit: 12)
        let range = NSRange(10..<12)

        XCTAssertTrue(change.affects(range))
        XCTAssertFalse(change.overlaps(range))
        XCTAssertEqual(change.transform(range: range), NSRange(9..<11))
    }

    func testMutationIncreasesLengthOfRange() {
        let change = RangeMutation(range: NSRange(5..<5), delta: 1, limit: 11)
        let range = NSRange(0..<10)

        XCTAssertTrue(change.affects(range))
        XCTAssertTrue(change.overlaps(range))
        XCTAssertEqual(change.transform(range: range), NSRange(0..<11))
    }

    func testMutationDecreasesLengthOfRange() {
        let change = RangeMutation(range: NSRange(5..<6), delta: -1, limit: 10)
        let range = NSRange(0..<10)

        XCTAssertTrue(change.affects(range))
        XCTAssertTrue(change.overlaps(range))
        XCTAssertEqual(change.transform(range: range), NSRange(0..<9))
    }

    func testMutationRemovesEntireRange() {
        let change = RangeMutation(range: NSRange(0..<5), delta: -5, limit: 10)

        let rangeA = NSRange(1..<3)

        XCTAssertTrue(change.affects(rangeA))
        XCTAssertTrue(change.overlaps(rangeA))
        XCTAssertNil(change.transform(range: rangeA))

        let rangeB = NSRange(1..<5)

        XCTAssertTrue(change.affects(rangeB))
        XCTAssertTrue(change.overlaps(rangeB))
        XCTAssertNil(change.transform(range: rangeB))

        let rangeC = NSRange(4..<5)

        XCTAssertTrue(change.affects(rangeC))
        XCTAssertTrue(change.overlaps(rangeC))
        XCTAssertNil(change.transform(range: rangeC))
    }

    func testMutationRemovesExactRange() {
        let change = RangeMutation(range: NSRange(5..<10), delta: -5, limit: 10)
        let range = NSRange(5..<10)

        XCTAssertTrue(change.affects(range))
        XCTAssertTrue(change.overlaps(range))
        XCTAssertEqual(change.transform(range: range), NSRange(5..<5))
    }

    func testMutationReplaceExactRange() {
        let change = RangeMutation(range: NSRange(5..<10), delta: 0, limit: 10)
        let range = NSRange(5..<10)

        XCTAssertTrue(change.affects(range))
        XCTAssertTrue(change.overlaps(range))
        XCTAssertEqual(change.transform(range: range), NSRange(5..<5))
    }
}
