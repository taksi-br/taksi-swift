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
    targets: [
        .target(
            name: "Taksi",
            path: "Sources"
        ),
        .testTarget(
            name: "TaksiTests",
            dependencies: ["Taksi"]
        )
    ]
)
