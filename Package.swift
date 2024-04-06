// swift-tools-version: 5.8

import PackageDescription

let package = Package(
	name: "Rearrange",
	platforms: [
		.macOS(.v10_13),
		.iOS(.v11),
		.tvOS(.v11),
		.watchOS(.v5),
		.macCatalyst(.v13),
	],
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
