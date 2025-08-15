import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Domain",
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
        ],
        defaultSettings: .recommended(excluding: ["ASSETCATALOG_COMPILER_APPICON_NAME"])
    ),
    targets: [
        .target(
            name: "Domain",
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "$(PRODUCT_BUNDLE_IDENTIFIER)Domain",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: nil,
            dependencies: [
                .external(name: "RxSwift"),
                .external(name: "RxCocoa"),
                .external(name: "Alamofire")
            ],
        )
    ]
)
