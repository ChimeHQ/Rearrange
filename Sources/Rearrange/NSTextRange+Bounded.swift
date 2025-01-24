#if os(macOS)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

@available(iOS 15.0, macOS 12.0, tvOS 15.0, macCatalyst 15.0, *)
extension NSTextRange : Bounded {
	public var lowerBound: NSTextLocation { location }
	public var upperBound: NSTextLocation { endLocation }
}
