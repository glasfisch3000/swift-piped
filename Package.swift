// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-piped",
    platforms: [
        .macOS("13")
    ],
    products: [
        .library(
            name: "Piped",
            targets: ["Piped"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/glasfisch3000/swiftui-api-interface.git", branch: "main")
    ],
    targets: [
        .target(
            name: "Piped",
            dependencies: [
                .product(name: "APIInterface", package: "swiftui-api-interface")
            ],
            path: "Sources/swift-piped"
        ),
    ]
)
