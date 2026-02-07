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
        settings: Settings = Settings.settings(),
        targets: [Target] = [],
        schemes: [Scheme] = [],
        packages: [Package] = [],
        infoPlist: InfoPlist = .default,
        resourceSynthesizers: [ResourceSynthesizer] = .default
    ) -> Project {
        return Project(
            name: name,
            packages: packages,
            settings: settings,
            targets: targets,
            schemes: schemes,
            resourceSynthesizers: resourceSynthesizers
        )
    }
}

extension Scheme {
    static func makeScheme(name: String) -> Scheme {
        let scheme: Scheme = .scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
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

public extension Target {
    static func makeTarget(
        name: String,
        destinations: Destinations,
        product: Product,
        productName: String? = nil,
        bundleId: String,
        deploymentTargets: DeploymentTargets = .iOS("16.0"),
        infoPlist: InfoPlist = .default,
        sources: SourceFilesList,
        resources: ResourceFileElements? = nil,
        entitlements: Entitlements? = nil,
        scripts: [TargetScript] = [],
        dependencies: [TargetDependency] = [],
        settings: Settings? = nil,
        coreDataModels: [CoreDataModel] = []
    ) -> Target {
        return Target.target(
            name: name,
            destinations: destinations,
            product: product,
            productName: productName,
            bundleId: bundleId,
            deploymentTargets: deploymentTargets,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            entitlements: entitlements,
            scripts: scripts,
            dependencies: dependencies,
            settings: settings,
            coreDataModels: coreDataModels
        )
    }
}
