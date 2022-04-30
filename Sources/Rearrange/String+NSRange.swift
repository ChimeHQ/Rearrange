import Foundation

public extension NSRange {
    func range(in string: String) -> Range<String.Index>? {
        return Range<String.Index>(self, in: string)
    }
}

public extension String {
    subscript(range: Range<Int>) -> Substring? {
        get {
            let start = index(startIndex, offsetBy: range.lowerBound)
            let end = index(start, offsetBy: range.count)

            return self[start..<end]
        }
    }

    subscript(range: NSRange) -> Substring? {
        get {
            return range.range(in: self).flatMap({ self[$0] })
        }
    }
}
