// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "MovieDatabaseUI",
    platforms: [.macOS("12.0"), .iOS("15.0")],
    products: [
        .library(name: "MovieDatabaseUI", targets: ["MovieDatabaseUI"]),
    ],
    dependencies: [
        .package(path: "../Foundational"),
        .package(path: "../Toolkit"),
        .package(path: "../MovieDatabase"),
    ],
    targets: [
        .target(
            name: "MovieDatabaseUI",
            dependencies: [
                "Foundational",
                "Toolkit",
                "MovieDatabase"
            ]
        ),
        .testTarget(
            name: "MovieDatabaseUITests",
            dependencies: ["MovieDatabaseUI"]
        ),
    ]
)
