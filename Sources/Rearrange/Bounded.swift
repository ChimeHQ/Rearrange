import Foundation

public protocol Bounded<Bound> {
	associatedtype Bound

	var lowerBound: Bound { get }
	var upperBound: Bound { get }
}

extension NSRange : Bounded {}
extension Range : Bounded {}
