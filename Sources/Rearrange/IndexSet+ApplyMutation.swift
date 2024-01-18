import Foundation

extension IndexSet {
	public func apply(mutation: RangeMutation) -> IndexSet {
		let ranges = nsRangeView.compactMap { $0.apply(mutation) }

		return IndexSet(ranges: ranges)
	}

	public mutating func applying(mutation: RangeMutation) {
		self = self.apply(mutation: mutation)
	}

	public func apply(mutations: [RangeMutation]) -> IndexSet {
		var ranges = nsRangeView

		for mutation in mutations {
			ranges = ranges.compactMap { $0.apply(mutation) }
		}

		return IndexSet(ranges: ranges)
	}

	public mutating func applying(mutations: [RangeMutation]) {
		self = self.apply(mutations: mutations)
	}
}
