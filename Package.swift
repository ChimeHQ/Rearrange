// swift-tools-version:5.5

import PackageDescription

let package = Package(
	name: "Rearrange",
	products: [
		.library(name: "Rearrange", targets: ["Rearrange"]),
	],
	dependencies: [],
	targets: [
		.target(name: "Rearrange", dependencies: []),
		.testTarget(name: "RearrangeTests", dependencies: ["Rearrange"]),
	]
)
