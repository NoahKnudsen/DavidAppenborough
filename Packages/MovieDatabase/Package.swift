// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "MovieDatabase",
    platforms: [.macOS("12.0"), .iOS("15.0")],
    products: [
        .library(name: "MovieDatabase", targets: ["MovieDatabase"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "MovieDatabase", dependencies: []),
        .testTarget(
            name: "MovieDatabaseTests",
            dependencies: ["MovieDatabase"],
            resources: [
                .copy("Resources/person-attenborough.json"),
                .copy("Resources/credits-attenborough.json"),
                .copy("Resources/tvshow-trials-of-life.json")
            ]
        ),
    ]
)
