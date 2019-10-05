// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Aesthete",
    platforms: [
        .macOS(.v10_14), .iOS(.v12),
    ],
    products: [
        .library(
            name: "Aesthete",
            targets: ["Aesthete"]),
    ],
    dependencies: [
        .package(url: "https://github.com/dunesailer/Utilities.git", from: "0.4.2"),
    ],
    targets: [
        .target(
            name: "Aesthete",
            dependencies: ["DunesailerUtilities"]),
        .testTarget(
            name: "AestheteTests",
            dependencies: ["Aesthete"]),
    ]
)
