import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "UnSplashExampleDomain",
    settings: .settings(
        base: [
            "SWIFT_VERSION": "5.9",
            "DEFAULT_PLATFORM_VERSION": "16.0",
            "MARKETING_VERSION": "1.0.0",
            "ENABLE_BITCODE": false,
            "ENABLE_TESTABILITY": true
        ],
        configurations: [
            .debug(name: "Debug", xcconfig: .relativeToRoot("Xcconfigs/Debug.xcconfig")),
            .release(name: "Release", xcconfig: .relativeToRoot("Xcconfigs/Release.xcconfig"))
        ],
        defaultSettings: .recommended(excluding: ["ASSETCATALOG_COMPILER_APPICON_NAME"])
    ),
    targets: [
        .target(
            name: "UnSplashExampleDomain",
            destinations: .iOS,
            product: .app,
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
