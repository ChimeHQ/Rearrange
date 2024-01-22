<div align="center">

[![Build Status][build status badge]][build status]
[![Platforms][platforms badge]][platforms]
[![Documentation][documentation badge]][documentation]
[![Discord][discord badge]][discord]

</div>

# Rearrange

Rearrange is a collection of utilities for making it easier to work with `NSRange`, `IndexSet`, `NSTextRange`/`UITextRange`, and `NSTextLocation`.

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

You can also use this class to tranform locations, `NSRange`, or even an `IndexSet`. This is handy for updating values as text is changed. This might seem easy, but there are a large number of edge cases that `RangeMutation` handles, including mutations that invalidate (for example completely delete) a range. 

## Extensions

**NSRange**

```swift
// convenience
static let zero: NSRange
static let notFound: NSRange
var max: Int

// shifting
func shifted(by delta: Int) -> NSRange?
func shifted(endBy delta: Int) -> NSRange?
func shifted(startBy delta: Int) -> NSRange?

// mutating
func clamped(to limit: Int) -> NSRange
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
init(integersIn range: NSRange)
init(ranges: [NSRange])
mutating func insert(range: NSRange)
mutating func insert(ranges: [NSRange])
mutating func remove(integersIn range: NSRange)
var nsRangeView: [NSRange]
func contains(integersIn range: NSRange) -> Bool
func intersects(integersIn range: NSRange) -> Bool
var limitSpanningRange: NSRange?
```

**String**

```swift
subscript(range: Range<Int>) -> Substring?
subscript(range: NSRange) -> Substring?
```

**NSTextLocation**

```swift
static func < (lhs: Self, rhs: Self) -> Bool
static func == (lhs: Self, rhs: Self) -> Bool
static func <= (lhs: Self, rhs: Self) -> Bool
static func > (lhs: Self, rhs: Self) -> Bool
static func >= (lhs: Self, rhs: Self) -> Bool
```

## Contributing and Collaboration

I would love to hear from you! Issues, Discussions, or pull requests work great. A [Discord server][discord] is also available for live help, but I have a strong bias towards answering in the form of documentation.

I prefer collaboration, and would love to find ways to work together if you have a similar project.

I prefer indentation with tabs for improved accessibility. But, I'd rather you use the system you want and make a PR than hesitate because of whitespace.

By participating in this project you agree to abide by the [Contributor Code of Conduct](CODE_OF_CONDUCT.md).

[build status]: https://github.com/ChimeHQ/Rearrange/actions
[build status badge]: https://github.com/ChimeHQ/Rearrange/workflows/CI/badge.svg
[platforms]: https://swiftpackageindex.com/ChimeHQ/Rearrange
[platforms badge]: https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FChimeHQ%2FRearrange%2Fbadge%3Ftype%3Dplatforms
[documentation]: https://swiftpackageindex.com/ChimeHQ/Rearrange/main/documentation
[documentation badge]: https://img.shields.io/badge/Documentation-DocC-blue
[discord]: https://discord.gg/esFpX6sErJ
[discord badge]: https://img.shields.io/badge/Discord-purple?logo=Discord&label=Chat&color=%235A64EC
