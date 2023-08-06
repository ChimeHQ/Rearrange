//
//  IndexSetExtenstionTests.swift
//  RearrangeTests
//
//  Created by Matt Massicotte on 2019-11-13.
//  Copyright © 2019 Chime Systems Inc. All rights reserved.
//

import XCTest

class IndexSetExtenstionTests: XCTestCase {
    func testSpanningRange() {
        var set = IndexSet()

        set.insert(range: NSRange(location: 0, length: 5))

        XCTAssertEqual(set.limitSpanningRange, NSRange(location: 0, length: 5))
    }

    func testLimitSpanningRangeWithOneIndex() {
        let set = IndexSet([42])

        XCTAssertEqual(set.limitSpanningRange, NSRange(location: 42, length: 1))
    }

    func testLimitSpanningRangeWithMultipleIndices() {
        let set = IndexSet([1, 7, 3])

        XCTAssertEqual(set.limitSpanningRange, NSRange(1...7))
    }

    func testLimitSpanningRangeWithEmptySet() {
        let set = IndexSet()

        XCTAssertNil(set.limitSpanningRange)
    }

    func testRangeInitializer() {
        var set = IndexSet()

        set.insert(range: NSRange(location: 0, length: 5))

        XCTAssertEqual(set, IndexSet(integersIn: NSRange(location: 0, length: 5)))
    }

    func testIntersets() {
        var set = IndexSet()

        XCTAssertFalse(set.intersects(integersIn: .zero))
        XCTAssertFalse(set.intersects(integersIn: .notFound))

        set.insert(range: NSRange(location: 1, length: 4))

        XCTAssertTrue(set.intersects(integersIn: NSRange(1..<2)))
        XCTAssertTrue(set.intersects(integersIn: NSRange(0..<5)))
        XCTAssertTrue(set.intersects(integersIn: NSRange(4..<5)))

        XCTAssertFalse(set.intersects(integersIn: NSRange(0..<1)))
        XCTAssertFalse(set.intersects(integersIn: NSRange(5..<5)))
        XCTAssertFalse(set.intersects(integersIn: NSRange(5..<6)))
    }
}
