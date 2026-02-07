import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Presentation",
    settings: .settings(
        base: [:],
        configurations: [
            .debug(name: "Debug"),
            .release(name: "Release")
        ]
    ),
    targets: [
        .target(
            name: "Presentation",
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "$(PRODUCT_BUNDLE_IDENTIFIER)Presentation",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: nil,
            dependencies: [
                .project(target: "Domain", path: "../Domain")
            ],
        )
    ]
)
