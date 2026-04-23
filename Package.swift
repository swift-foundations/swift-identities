// swift-tools-version: 6.3.1

import PackageDescription

let package = Package(
    name: "swift-identities",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26)
    ],
    products: [
        .library(
            name: "Identities",
            targets: ["Identities"]
        )
    ],
    dependencies: [
        .package(path: "../../swift-primitives/swift-tagged-primitives"),
        .package(path: "../../swift-ietf/swift-rfc-9562"),
        .package(path: "../swift-random")
    ],
    targets: [
        .target(
            name: "Identities",
            dependencies: [
                .product(name: "Tagged Primitives", package: "swift-tagged-primitives"),
                .product(name: "RFC 9562", package: "swift-rfc-9562"),
                .product(name: "Random", package: "swift-random")
            ]
        ),
        .testTarget(
            name: "Identities Tests",
            dependencies: [
                "Identities",
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
