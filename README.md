[![Build Status][build status badge]][build status]
[![License][license badge]][license]
[![Platforms][platforms badge]][platforms]

# Rearrange

Rearrange is a collection of utilities for making it easier to work with `NSRange` and `NSTextRange`. It's particularly handy when used with the Cocoa text system.

## Integration

Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/ChimeHQ/Rearrange")
]
```

## Types

**RangeMutation**

This is a struct that encapsulates a single change to an `NSRange`. It's useful for serializing, queuing, or otherwise storing changes and applying them.

You can also use this class to tranform individual points or other `NSRange`s. This is handy for updating a set of stored `NSRange`s as text is changed. This might seem easy, but there are a large number of edge cases that `RangeMutation` handles, including mutations that invalidate (for example completely delete) a range. 

## Extensions

**NSRange**

```swift
// convenience
static var zero: NSRange
static var notFound: NSRange
var max: Int

// shifting
public func shifted(by delta: Int) -> NSRange?
public func shifted(startBy delta: Int) -> NSRange?
public func shifted(endBy delta: Int) -> NSRange?

// mutating
public func clamped(to limit: Int) -> NSRange

func apply(_ change: RangeMutation) -> NSRange?

// creating
init(_ textRange: NSTextRange, provider: NSTextElementProvider)
init?(_ textRange: UITextRange, textView: UITextView)

// working with Swift String
func range(in string: String) -> Range<String.Index>?
```

**NSTextRange**

```swift
// creating
convenience init?(_ range: NSRange, provider: NSTextElementProvider)
convenience init?(_ offset: Int, provider: NSTextElementProvider)
```

**UITextRange**

```swift
// creating
convenience init?(_ range: NSRange, provider: NSTextElementProvider)
```

**IndexSet**

```swift
mutating func insert(range: NSRange)
mutating func insert(ranges: [NSRange])
mutating func remove(integersIn range: NSRange)
var nsRangeView: [NSRange]
func contains(integersIn range: NSRange) -> Bool
func intersects(integersIn range: NSRange) -> Bool
var limitSpanningRange: NSRange?
```

**String**

```Swift
subscript(range: Range<Int>) -> Substring?
subscript(range: NSRange) -> Substring?
```

### Suggestions or Feedback

We'd love to hear from you! Get in touch via an issue or pull request.

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

[build status]: https://github.com/ChimeHQ/Rearrange/actions
[build status badge]: https://github.com/ChimeHQ/Rearrange/workflows/CI/badge.svg
[license]: https://opensource.org/licenses/BSD-3-Clause
[license badge]: https://img.shields.io/github/license/ChimeHQ/Rearrange
[platforms]: https://swiftpackageindex.com/ChimeHQ/Rearrange
[platforms badge]: https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FChimeHQ%2FRearrange%2Fbadge%3Ftype%3Dplatforms
