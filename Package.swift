// swift-tools-version:6.1

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
    targets: [
        .target(
            name: "SystemNotification"
        ),
        .testTarget(
            name: "SystemNotificationTests",
            dependencies: ["SystemNotification"]
        )
    ]
)
