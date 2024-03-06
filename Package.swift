// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "SystemNotification",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "SystemNotification",
            targets: ["SystemNotification"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SystemNotification",
            dependencies: []
        ),
        .testTarget(
            name: "SystemNotificationTests",
            dependencies: ["SystemNotification"]
        )
    ]
)
