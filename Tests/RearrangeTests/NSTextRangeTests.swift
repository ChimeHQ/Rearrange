import XCTest
#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

#if os(macOS) || os(iOS) || os(tvOS) || os(visionOS)

class NSTextRangeTests: XCTestCase {
    func testFullDocumentRange() throws {
        if #available(iOS 15.0, macOS 12.0, tvOS 15.0, *) {
            let content = NSTextContentStorage()

            content.attributedString = NSAttributedString(string: "abcdef")

            let range = NSRange(content.documentRange, provider: content)

            XCTAssertEqual(range, NSRange(0..<6))

            let textRange = NSTextRange(NSRange(0..<6), provider: content)

            XCTAssertEqual(textRange, content.documentRange)
        } else {
            throw XCTSkip()
        }
    }
}

#endif
