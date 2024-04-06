// swift-tools-version: 5.8

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

let swiftSettings: [SwiftSetting] = [
	.enableExperimentalFeature("StrictConcurrency")
]

for target in package.targets {
	var settings = target.swiftSettings ?? []
	settings.append(contentsOf: swiftSettings)
	target.swiftSettings = settings
}
