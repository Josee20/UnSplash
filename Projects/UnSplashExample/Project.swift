import ProjectDescription
import ProjectDescriptionHelpers

//let project = Project(
//    name: "UnSplashExample",
//    settings: .settings(
//        base: [
//            "SWIFT_VERSION": "5.9",
//            "DEFAULT_PLATFORM_VERSION": "16.0",
//            "MARKETING_VERSION": "1.0.0",
//            "ENABLE_BITCODE": false,
//            "ENABLE_TESTABILITY": true
//        ],
//        configurations: [
//            .debug(name: "Debug", xcconfig: .relativeToRoot("Xcconfigs/Debug.xcconfig")),
//            .release(name: "Release", xcconfig: .relativeToRoot("Xcconfigs/Release.xcconfig"))
//        ],
//        defaultSettings: .recommended(excluding: ["ASSETCATALOG_COMPILER_APPICON_NAME"])
//    ),
//    targets: [
//        .target(
//            name: "UnSplashExample",
//            destinations: .iOS,
//            product: .app,
//            bundleId: "$(PRODUCT_BUNDLE_IDENTIFIER)",
//            deploymentTargets: .iOS("16.0"),
//            infoPlist: .file(path: "SupportFile/Info.plist"),
//            sources: ["Sources/**"],
//            resources: ["Resources/**"],
//            dependencies: [
//                .external(name: "RxSwift"),
//                .external(name: "RxCocoa"),
//                .external(name: "Alamofire"),
//                .external(name: "SnapKit"),
//                .external(name: "Kingfisher"),
//                .external(name: "ReactorKit")
//            ],
//            coreDataModels: [.coreDataModel("Sources/Data/CoreDataStorage/CoreDataStorage.xcdatamodeld")]
//        ),
//        .target(
//            name: "UnSplashExampleTests",
//            destinations: .iOS,
//            product: .unitTests,
//            bundleId: "io.tuist.UnSplashExampleTests",
//            infoPlist: .default,
//            sources: ["Tests/**"],
//            resources: [],
//            dependencies: [.target(name: "UnSplashExample")]
//        ),
//    ],
//    schemes: [.makeScheme(name: "UnsplashExample")]
//)

let project = Project.makeModule(
    name: "UnSplashExample",
    deploymentTarget: .iOS("16.0")
)

extension Scheme {
    static func makeScheme(name: String) -> Scheme {
        let scheme: Scheme = .scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            testAction: .targets(
                ["\(name)Tests"],
                configuration: BuildTarget.debug.configurationName,
                options: .options(
                    coverage: true,
                    codeCoverageTargets: ["\(name)"]
                )
            ),
            runAction: .runAction(
                configuration: BuildTarget.debug.configurationName,
                arguments: .arguments(
                    environmentVariables: ["OS_ACTIVITY_MODE": "disable"]
                )
            ),
            archiveAction: .archiveAction(
                configuration: BuildTarget.release.configurationName,
                revealArchiveInOrganizer: true
            ),
            profileAction: .profileAction(
                configuration: BuildTarget.release.configurationName,
                arguments: .arguments(
                    environmentVariables: ["OS_ACTIVITY_MODE": "disable"]
                )
            ),
            analyzeAction: .analyzeAction(
                configuration: BuildTarget.debug.configurationName
            )
        )
        return scheme
    }
}
