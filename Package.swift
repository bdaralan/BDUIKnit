// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BDUIKnit",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "BDUIKnit", targets: ["BDUIKnit"]),
    ],
    targets: [
        .target(name: "BDUIKnit", dependencies: []),
        .testTarget(name: "BDUIKnitTests", dependencies: ["BDUIKnit"]),
    ]
)
