//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 이동기 on 8/16/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "ThirdPartyLibs",
    settings: .settings(
        configurations: [
            .debug(name: "Debug"),
            .release(name: "Release")
        ],
        defaultSettings: .recommended(excluding: ["ASSETCATALOG_COMPILER_APPICON_NAME"])
    ),
    targets: [
        .target(
            name: "ThirdPartyLibs",
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "$(PRODUCT_BUNDLE_IDENTIFIER)ThirdPartyLibs",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            dependencies: [
                .external(name: "RxSwift"),
                .external(name: "RxCocoa"),
                .external(name: "Alamofire"),
                .external(name: "SnapKit"),
                .external(name: "Kingfisher"),
                .external(name: "ReactorKit")
            ],
        )
    ]
)
