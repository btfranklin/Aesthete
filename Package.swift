// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Aesthete",
    platforms: [
        .macOS(.v10_15), .iOS(.v13),
    ],
    products: [
        .library(
            name: "Aesthete",
            targets: ["Aesthete"]),
    ],
    dependencies: [
        .package(name: "Dunesailer Utilities", url: "https://github.com/dunesailer/Utilities.git", from: "2.0.2"),
    ],
    targets: [
        .target(
            name: "Aesthete",
            dependencies: [.product(name: "DunesailerUtilities", package: "Dunesailer Utilities")]),
        .testTarget(
            name: "AestheteTests",
            dependencies: ["Aesthete"]),
    ]
)
