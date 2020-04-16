[![Github CI](https://github.com/ChimeHQ/Rearrange/workflows/CI/badge.svg)](https://github.com/ChimeHQ/Rearrange/actions)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg)](https://github.com/Carthage/Carthage)
![](https://img.shields.io/badge/Swift-5.0-orange.svg)

# Rearrange

Rearrange is a collection of utilities for making it easier to work with NSRange. It's particularly handy when used with the Cocoa text system.

## Integration

Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/ChimeHQ/Rearrange.git")
]
```

Carthage:

```
github "ChimeHQ/Rearrange"
```

## Types

**RangeMutation**

This is a struct that encapsulates a single change to an NSRange. It's useful for serializing, queuing, or otherwise storing changes and applying them.

You can also use this class to tranform individual points or other NSRanges. This is handy for updating a set of stored NSRanges as text is changed. This might seem easy, but there are a large number of edge cases that RangeMutation handles, including mutations that invalidate (for example completely delete) a range. 

## Extensions

**NSRange**

```swift
// convenience
static var zero
var max: Int

// shifting
public func shifted(by delta: Int) -> NSRange?
public func shifted(startBy delta: Int) -> NSRange?
public func shifted(endBy delta: Int) -> NSRange?

// mutating
func apply(_ change: RangeMutation) -> NSRange?
```

**IndexSet**

```swift
mutating func insert(range: NSRange)
mutating func insert(ranges: [NSRange])
var nsRangeView: [NSRange]
func contains(integersIn range: NSRange) -> Bool
var limitSpanningRange: NSRange?
```

### Suggestions or Feedback

We'd love to hear from you! Get in touch via [twitter](https://twitter.com/chimehq), an issue, or a pull request.

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.
