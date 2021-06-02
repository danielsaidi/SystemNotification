// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SystemNotification",
    platforms: [
        .macOS(.v11),
        .iOS(.v14),
        .tvOS(.v14),
        .watchOS(.v7)
    ],
    products: [
        .library(
            name: "SystemNotification",
            targets: ["SystemNotification"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SystemNotification",
            dependencies: []),
        .testTarget(
            name: "SystemNotificationTests",
            dependencies: ["SystemNotification"])
    ]
)
