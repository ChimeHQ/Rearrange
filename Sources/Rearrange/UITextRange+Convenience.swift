#if os(iOS) || os(tvOS) || os(visionOS)
import UIKit

extension NSRange {
	@MainActor
	public init?(_ textRange: UITextRange, textView: UITextView) {
        let location = textView.offset(from: textView.beginningOfDocument, to: textRange.start)
        let length = textView.offset(from: textRange.start, to: textRange.end)

        if location < 0 || length < 0 {
            return nil
        }

        self.init(location: location, length: length)
    }
}

extension UITextView {
	@MainActor
	public func textRange(with range: NSRange) -> UITextRange? {
        guard let start = position(from: beginningOfDocument, offset: range.location) else {
            return nil
        }

        guard let end = position(from: start, offset: range.length) else {
            return nil
        }

        return textRange(from: start, to: end)
    }
}
#endif
