import Foundation

public protocol TextRangeCalculating<TextRange> {
	associatedtype TextRange: Bounded

	typealias Position = TextRange.Bound

	var beginningOfDocument: Position { get }
	var endOfDocument: Position { get }

	func textRange(from start: Position, to end: Position) -> TextRange?
	func position(from position: Position, offset: Int) -> Position?
	func offset(from start: Position, to end: Position) -> Int
	func compare(_ position: Position, to other: Position) -> ComparisonResult
}

extension TextRangeCalculating {
	public func textRange(from range: NSRange) -> TextRange? {
		guard
			let start = position(from: beginningOfDocument, offset: range.location),
			let end = position(from: start, offset: range.length)
		else {
			return nil
		}

		return textRange(from: start, to: end)
	}
}

extension TextRangeCalculating where TextRange.Bound == Int {
	public var beginningOfDocument: Position {
		0
	}
	
	public func position(from position: Position, offset: Int) -> Position? {
		position + offset
	}

	public func offset(from start: Position, to end: Position) -> Int {
		end - start
	}

	public func compare(_ position: Position, to other: Position) -> ComparisonResult {
		if position > other {
			return .orderedDescending
		}

		if position < other {
			return .orderedAscending
		}

		return .orderedSame
	}
}

public struct CalculatedPosition<Calculator: TextRangeCalculating> {
	public typealias Position = Calculator.TextRange.Bound

	public let calculator: Calculator
	public let value: Position

	public init(_ value: Position, calculator: Calculator) {
		self.value = value
		self.calculator = calculator
	}
}

extension CalculatedPosition : Sendable where Calculator : Sendable, Position : Sendable {}
extension CalculatedPosition : Hashable where Calculator : Hashable & AnyObject, Position : Hashable {}

extension CalculatedPosition : Equatable where Calculator : AnyObject {
	public static func == (lhs: CalculatedPosition<Calculator>, rhs: CalculatedPosition<Calculator>) -> Bool {
		precondition(lhs.calculator === rhs.calculator)

		return lhs.calculator.compare(lhs.value, to: rhs.value) == .orderedSame
	}
}

extension CalculatedPosition : Comparable where Calculator : AnyObject {
	public static func < (lhs: Self, rhs: Self) -> Bool {
		precondition(lhs.calculator === rhs.calculator)

		return lhs.calculator.compare(lhs.value, to: rhs.value) == .orderedAscending
	}
}

/// A type that combines both an abstract range and a calcuating system to work with it.
public struct CalculatedRange<Calculator: TextRangeCalculating> : Bounded {
	public typealias Position = Calculator.TextRange.Bound

	public let lowerBound: CalculatedPosition<Calculator>
	public let upperBound: CalculatedPosition<Calculator>

	public let calculator: Calculator
	public let range: Calculator.TextRange

	public init(_ range: Calculator.TextRange, calculator: Calculator) {
		self.range = range
		self.calculator = calculator
		self.lowerBound = CalculatedPosition(range.lowerBound, calculator: calculator)
		self.upperBound = CalculatedPosition(range.upperBound, calculator: calculator)
	}

	public var isEmpty: Bool {
		calculator.compare(range.lowerBound, to: range.upperBound) == .orderedSame
	}
}

extension CalculatedRange : Sendable where Calculator : Sendable, Position : Sendable {}
extension CalculatedRange : Equatable where Calculator : AnyObject, Calculator.TextRange : Equatable {
	public static func == (lhs: CalculatedRange<Calculator>, rhs: CalculatedRange<Calculator>) -> Bool {
		precondition(lhs.calculator === rhs.calculator)

		return lhs.range == rhs.range
	}
}
extension CalculatedRange : Hashable where Calculator : Hashable & AnyObject, Calculator.TextRange : Hashable, Position : Hashable {}

extension CalculatedRange : Comparable where Self : Equatable {
	public static func < (lhs: Self, rhs: Self) -> Bool {
		lhs.lowerBound < rhs.lowerBound
	}
}

extension CalculatedRange {
	public func offset(by delta: Int) -> Self? {
		if delta == 0 {
			return self
		}

		guard
			let start = calculator.position(from: range.lowerBound, offset: delta),
			let end = calculator.position(from: range.upperBound, offset: delta),
			let newRange = calculator.textRange(from: start, to: end)
		else {
			return nil
		}

		return Self(newRange, calculator: calculator)
	}

	public func intersection(with other: Self) -> Self? {
		let maxLower = calculator.compare(range.lowerBound, to: other.range.lowerBound) == .orderedAscending ? other.range.lowerBound : range.lowerBound
		let minUpper = calculator.compare(range.upperBound, to: other.range.upperBound) == .orderedAscending ? range.upperBound : other.range.upperBound

		if calculator.compare(maxLower, to: minUpper) == .orderedDescending {
			return nil
		}

		guard let newRange = calculator.textRange(from: maxLower, to: minUpper) else {
			return nil
		}

		return Self(newRange, calculator: calculator)
	}
}
