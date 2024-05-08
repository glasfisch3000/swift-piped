// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-piped",
    products: [
        .library(
            name: "swift-piped",
            targets: ["swift-piped"]
        ),
    ],
    targets: [
        .target(
            name: "swift-piped"
        ),
    ]
)
