// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Aesthete",
    platforms: [
        .macOS(.v11), .iOS(.v14), .tvOS(.v14), .watchOS(.v7)
    ],
    products: [
        .library(
            name: "Aesthete",
            targets: ["Aesthete"]),
    ],
    dependencies: [
        .package(url: "https://github.com/btfranklin/ControlledChaos",
                    .upToNextMajor(from: "1.3.2")),
    ],
    targets: [
        .target(
            name: "Aesthete",
            dependencies: [
                .product(name: "ControlledChaos",
                         package: "ControlledChaos")
            ]),
        .testTarget(
            name: "AestheteTests",
            dependencies: ["Aesthete"]),
    ]
)
