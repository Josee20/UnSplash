//
//  Project+Templates.swift
//  Packages
//
//  Created by 이동기 on 8/6/25.
//

import ProjectDescription

extension Project {
    public static func makeModule(
        name: String,
        organizationName: String = "dklee",
        packages: [Package] = [],
        deploymentTarget: DeploymentTargets = .iOS("16.0"),
        dependencies: [TargetDependency] = [],
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements? = ["Resources/**"],
        infoPlist: InfoPlist = .default
    ) -> Project {
        let settings = Settings.settings(
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
        )
        
        let appTarget = Target.target(
            name: "UnSplashExample",
            destinations: .iOS,
            product: .app,
            bundleId: "$(PRODUCT_BUNDLE_IDENTIFIER)",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .file(path: "SupportFile/Info.plist"),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "Feature", path: "../Feature")
            ]
        )

        let testTarget = Target.target(
            name: "UnSplashExampleTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.UnSplashExampleTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "UnSplashExample")]
        )

        let schemes: [Scheme] = [.makeScheme(target: .debug, name: name)]
        let targets: [Target] = [appTarget, testTarget]
        
        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            settings: settings,
            targets: targets,
            schemes: schemes
        )
    }
}

extension Scheme {
    static func makeScheme(target: ConfigurationName, name: String) -> Scheme {
        return Scheme.scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            testAction: .targets(
                ["\(name)Tests"],
                configuration: target,
                options: .options(coverage: true, codeCoverageTargets: ["\(name)"])
            ),
            runAction: .runAction(configuration: target),
            archiveAction: .archiveAction(configuration: target),
            profileAction: .profileAction(configuration: target),
            analyzeAction: .analyzeAction(configuration: target)
        )
    }
}

extension Target {
    static func makeTarget(
        name: String,
        product: Product,
        bundleId: String,
        deploymentTarget: DeploymentTargets = .iOS("16.0"),
        infoPlist: InfoPlist,
        sources: SourceFilesList,
        resources: ResourceFileElements?,
        dependencies: [TargetDependency] = [],
        coreDataModels: [CoreDataModel] = []
    ) -> Target {
        return Target.target(
            name: name,
            destinations: .iOS,
            product: product,
            bundleId: bundleId,
            deploymentTargets: deploymentTarget,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            dependencies: dependencies,
            coreDataModels: coreDataModels
        )
    }
}
