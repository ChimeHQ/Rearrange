import Testing

import Rearrange

struct MockCalculator: TextRangeCalculating {
	typealias TextRange = Range<Int>

	var endOfDocument: Position

	func textRange(from start: Position, to end: Position) -> Range<Int>? {
		start..<end
	}
}

struct TextRangeCalculatingTests {
	@Test
	func validRange() {
		let calculator = MockCalculator(endOfDocument: 10)

		#expect(calculator.validRange(-1..<0) == false)
		#expect(calculator.validRange(10..<11) == false)
		#expect(calculator.validRange(10..<10))
		#expect(calculator.validRange(9..<10))
		#expect(calculator.validRange(0..<1))
	}
}
