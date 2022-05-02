// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "Toolkit",
    platforms: [.macOS("12.0"), .iOS("15.0")],
    products: [
        .library(name: "Toolkit", targets: ["Toolkit"]),
    ],
    dependencies: [
        .package(path: "../Foundational"),
    ],
    targets: [
        .target(
            name: "Toolkit",
            dependencies: ["Foundational"]
        )
    ]
)
