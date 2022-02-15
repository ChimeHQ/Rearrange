import XCTest
#if os(macOS)
import AppKit
#elseif os(iOS) || os(tvOS)
import UIKit
#endif

#if os(macOS) || os(iOS) || os(tvOS)

@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
class NSTextRangeTests: XCTestCase {
    func testFullDocumentRange() {
        let content = NSTextContentStorage()

        content.attributedString = NSAttributedString(string: "abcdef")

        let range = NSRange(content.documentRange, provider: content)

        XCTAssertEqual(range, NSRange(0..<6))

        let textRange = NSTextRange(NSRange(0..<6), provider: content)

        XCTAssertEqual(textRange, content.documentRange)
    }
}

#endif
