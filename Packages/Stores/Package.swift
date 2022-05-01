// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "Stores",
    platforms: [.macOS("12.0"), .iOS("15.0")],
    products: [
        .library(name: "Stores", targets: ["Stores"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "Stores", dependencies: []),
        .testTarget(name: "StoresTests", dependencies: ["Stores"]),
    ]
)
