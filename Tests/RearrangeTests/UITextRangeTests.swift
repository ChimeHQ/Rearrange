import XCTest
import Rearrange
#if os(iOS) || os(tvOS)
import UIKit

final class UITextRangeTests: XCTestCase {
    func testTextRangeWithRange() throws {
        let view = UITextView()

        view.text = "abc"

        let textRange = try XCTUnwrap(view.textRange(with: NSRange(0..<3)))
        let fullRange = try XCTUnwrap(view.textRange(from: view.beginningOfDocument, to: view.endOfDocument))

        XCTAssertEqual(textRange, fullRange)
    }

    func testRangeWithTextRange() throws {
        let view = UITextView()

        view.text = "abc"

        let textRange = try XCTUnwrap(view.textRange(from: view.beginningOfDocument, to: view.endOfDocument))

        let range = NSRange(textRange, textView: view)

        XCTAssertEqual(range, NSRange(0..<3))
    }
}
#endif
