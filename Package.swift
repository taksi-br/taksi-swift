// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Taksi",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Taksi",
            targets: [
                "Taksi"
            ]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/rogerluan/JSEN", .upToNextMajor(from: "1.2.1")),
    ],
    targets: [
        .target(
            name: "Taksi",
            dependencies: ["JSEN"],
            path: "Sources"
        ),
        .testTarget(
            name: "TaksiTests",
            dependencies: ["Taksi"]
        )
    ]
)
