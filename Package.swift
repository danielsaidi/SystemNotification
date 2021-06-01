// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SystemNotification",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "SystemNotification",
            targets: ["SystemNotification"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SystemNotification",
            dependencies: []),
        .testTarget(
            name: "SystemNotificationTests",
            dependencies: ["SystemNotification"]),
    ]
)
