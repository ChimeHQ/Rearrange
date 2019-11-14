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

    func testLimitSpanningRangeWithEmptySet() {
        let set = IndexSet()

        XCTAssertNil(set.limitSpanningRange)
    }

    func testRangeInitializer() {
        var set = IndexSet()

        set.insert(range: NSRange(location: 0, length: 5))

        XCTAssertEqual(set, IndexSet(integersIn: NSRange(location: 0, length: 5)))
    }
}
