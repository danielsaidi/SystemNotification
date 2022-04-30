// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "SystemNotification",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
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
