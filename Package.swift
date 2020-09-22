// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "HomeScreenMonoid",
    platforms: [.macOS(.v10_15)],
    products: [
        .library(
            name: "HomeScreenMonoid",
            targets: ["HomeScreenMonoid"]),
    ],
    dependencies: [
        .package(name: "Bow", url: "https://github.com/bow-swift/bow", from: "0.8.0"),
        .package(name: "SwiftCheck", url: "https://github.com/bow-swift/SwiftCheck", from: "0.12.1"),
    ],
    targets: [
        .target(
            name: "HomeScreenMonoid",
            dependencies: [.product(name: "Bow", package: "Bow")]),
        .testTarget(
            name: "HomeScreenMonoidTests",
            dependencies: [
                .target(name: "HomeScreenMonoid"),
                .product(name: "SwiftCheck", package: "SwiftCheck"),
                .product(name: "BowGenerators", package: "Bow"),
                .product(name: "BowLaws", package: "Bow")
        ]),
    ]
)
