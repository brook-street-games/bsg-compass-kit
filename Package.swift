// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "BSGCompassKit",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "BSGCompassKit",
            targets: ["BSGCompassKit"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "BSGCompassKit",
            dependencies: [],
            path: "BSGCompassKit/BSGCompassKit",
            exclude: ["Assets/Info.plist"]
        ),
        .testTarget(
            name: "BSGCompassKitTests",
            dependencies: ["BSGCompassKit"],
            path: "BSGCompassKit/BSGCompassKitTests",
            exclude: ["Assets/Info.plist"]
        ),
    ]
)
