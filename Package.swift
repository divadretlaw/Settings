// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Settings",
    platforms: [.iOS(.v13), .macOS(.v11)],
    products: [
        .library(
            name: "Settings",
            targets: ["Settings"]),
    ],
    dependencies: [
        .package(name: "KeychainSwift", url: "https://github.com/evgenyneu/keychain-swift", from: "19.0.0")
    ],
    targets: [
        .target(
            name: "Settings",
            dependencies: ["KeychainSwift"]),
        .testTarget(
            name: "SettingsTests",
            dependencies: ["Settings"]),
    ]
)
