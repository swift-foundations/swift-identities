// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "swift-identities",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26),
    ],
    products: [
        .library(
            name: "Identities",
            targets: ["Identities"]
        ),
    ],
    dependencies: [
        .package(path: "../../swift-primitives/swift-identity-primitives"),
        .package(path: "../../swift-standards/swift-rfc-9562"),
        .package(path: "../swift-random"),
        .package(path: "../swift-testing-extras"),
    ],
    targets: [
        .target(
            name: "Identities",
            dependencies: [
                .product(name: "Identity Primitives", package: "swift-identity-primitives"),
                .product(name: "RFC 9562", package: "swift-rfc-9562"),
                .product(name: "Random", package: "swift-random"),
            ]
        ),
        .testTarget(
            name: "Identities Tests",
            dependencies: [
                "Identities",
                .product(name: "Testing Extras", package: "swift-testing-extras"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin].contains(target.type) {
    let settings: [SwiftSetting] = [
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
    ]
    target.swiftSettings = (target.swiftSettings ?? []) + settings
}
