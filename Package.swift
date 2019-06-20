// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Rearrange",
    products: [
        .library(name: "Rearrange", targets: ["Rearrange"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "Rearrange", dependencies: [], path: "Rearrange/"),
        .testTarget(name: "RearrangeTests", dependencies: ["Rearrange"], path: "RearrangeTests/"),
    ]
)
