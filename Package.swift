// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-piped",
    platforms: [
        .macOS("12")
    ],
    products: [
        .library(
            name: "Piped",
            targets: ["Piped"]
        ),
    ],
    targets: [
        .target(
            name: "Piped",
            path: "Sources/swift-piped"
        ),
    ]
)
