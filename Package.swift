// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "SystemNotification",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v10),
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
