import Foundation

extension IndexSet {
	public func apply(_ mutation: RangeMutation) -> IndexSet {
		let ranges = nsRangeView.compactMap { $0.apply(mutation) }

		return IndexSet(ranges: ranges)
	}

	public mutating func applying(_ mutation: RangeMutation) {
		self = self.apply(mutation)
	}

	public func apply(_ mutations: [RangeMutation]) -> IndexSet {
		var ranges = nsRangeView

		for mutation in mutations {
			ranges = ranges.compactMap { $0.apply(mutation) }
		}

		return IndexSet(ranges: ranges)
	}

	public mutating func applying(_ mutations: [RangeMutation]) {
		self = self.apply(mutations)
	}
}
