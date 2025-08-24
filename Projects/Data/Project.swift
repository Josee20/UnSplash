import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Data",
    settings: .settings(
        base: [:],
        configurations: [
            .debug(name: "Debug"),
            .release(name: "Release")
        ]
    ),
    targets: [
        .target(
            name: "DataResources",
            destinations: .iOS,
            product: .bundle,
            bundleId: "$(PRODUCT_BUNDLE_IDENTIFIER)DataResources",
            coreDataModels: [.coreDataModel("Sources/CoreDataStorage/CoreDataStorage.xcdatamodeld")]
        ),
        .target(
            name: "Data",
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "$(PRODUCT_BUNDLE_IDENTIFIER)Data",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: nil,
            dependencies: [
                .project(target: "Domain", path: "../Domain"),
                .target(name: "DataResources")
            ]
        )
    ]
)
