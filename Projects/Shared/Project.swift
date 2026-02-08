import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Shared",
    settings: .settings(
        base: [
            "SWIFT_VERSION": "5.9",
            "DEFAULT_PLATFORM_VERSION": "16.0",
            "ENABLE_BITCODE": false,
            "ENABLE_TESTABILITY": true
        ],
        configurations: [
            .debug(name: "Debug"),
            .release(name: "Release")
        ]
    ),
    targets: [
        .target(
            name: "Shared",
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "$(PRODUCT_BUNDLE_IDENTIFIER)Domain",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: nil,
            dependencies: [
                .project(target: "ThirdPartyLibs", path: "../ThirdPartyLibs")
            ],
        )
    ]
)
