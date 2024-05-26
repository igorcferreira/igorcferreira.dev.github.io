// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DevelopmentBlog",
    platforms: [.macOS(.v13)],
    dependencies: [
        .package(url: "https://github.com/twostraws/Ignite.git", branch: "main"),
        .package(name: "ArkanaKeys", path: "./keys/ArkanaKeys")
    ],
    targets: [
        .executableTarget(
            name: "DevelopmentBlog",
            dependencies: [
                "Ignite",
                .product(name: "ArkanaKeys", package: "ArkanaKeys")
            ]
        ),
    ]
)
