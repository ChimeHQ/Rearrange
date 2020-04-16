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
}
