import Foundation

#if os(macOS)
import AppKit
#elseif os(iOS) || os(tvOS)
import UIKit
#endif

#if (os(macOS) || os(iOS) || os(tvOS)) && compiler(>=5.5)

@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
public extension NSTextLocation {
    static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.compare(rhs) == .orderedAscending
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
public extension NSRange {
    init(_ textRange: NSTextRange, provider: NSTextElementProvider) {
        let docLocation = provider.documentRange.location

        let start = provider.offset?(from: docLocation, to: textRange.location) ?? NSNotFound
        if start == NSNotFound {
            self.init(location: start, length: 0)
            return
        }

        let end = provider.offset?(from: docLocation, to: textRange.endLocation) ?? NSNotFound
        if end == NSNotFound {
            self.init(location: NSNotFound, length: 0)
            return
        }

        self.init(start..<end)
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
@available(watchOS, unavailable)
public extension NSTextRange {
    convenience init?(_ range: NSRange, provider: NSTextElementProvider) {
        let docLocation = provider.documentRange.location

        guard let start = provider.location?(docLocation, offsetBy: range.location) else {
            return nil
        }

        guard let end = provider.location?(start, offsetBy: range.length) else {
            return nil
        }

        self.init(location: start, end: end)
    }

    convenience init?(_ offset: Int, provider: NSTextElementProvider) {
        let docLocation = provider.documentRange.location

        guard let start = provider.location?(docLocation, offsetBy: offset) else {
            return nil
        }

        self.init(location: start)
    }
}

#endif
