import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "CollectionFeature",
    settings: .settings(
        base: [:],
        configurations: [
            .debug(name: "Debug"),
            .release(name: "Release")
        ]
    ),
    targets: [
        .target(
            name: "CollectionFeature",
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "$(PRODUCT_BUNDLE_IDENTIFIER)CollectionFeature",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: nil,
            dependencies: [
                .project(target: "Presentation", path: "../../Presentation"),
                .project(target: "Data", path: "../../Data")
            ]
        )
    ]
)
