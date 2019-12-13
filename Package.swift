// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Freelance_bot",
        products: [
            Product.executable(
                    name: "Freelance_bot",
                    targets: ["Freelance_bot"]
            ),
        ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/SwiftyBeaver/SwiftyBeaver.git", from: "1.6.2"),
        .package(url: "https://github.com/shaneqi/ZEGBot.git", .upToNextMajor(from: "4.2.0")),
        .package(url: "https://github.com/scinfu/SwiftSoup.git", from: "1.7.4"),
        .package(url: "https://github.com/stephencelis/SQLite.swift.git", from: "0.11.5"),
        .package(url: "https://github.com/IBM-Swift/Configuration.git", from: "3.0.2"),

    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Freelance_bot",
            dependencies: ["ZEGBot", "SwiftSoup", "SQLite", "SwiftyBeaver", "Configuration"]),
        .testTarget(
            name: "Freelance_botTests",
            dependencies: ["Freelance_bot"]),
    ]
)
