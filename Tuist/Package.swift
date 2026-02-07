// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription
    import ProjectDescriptionHelpers

    let packageSettings = PackageSettings(
        productTypes: [
            "Alamofire": .framework,
            "RxSwift": .framework,
            "RxCocoa": .framework,
            "RxRelay": .framework,
            "RxCocoaRuntime": .framework,
            "SnapKit": .framework,
            "ReactorKit": .framework
        ]
    )
#endif

let package = Package(
    name: "Libraries",
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.1.0")),
        .package(url: "https://github.com/Alamofire/Alamofire", from: "5.9.0"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.7.1")),
        .package(url: "https://github.com/onevcat/Kingfisher.git", .upToNextMajor(from: "8.0.0")),
        .package(url: "https://github.com/ReactorKit/ReactorKit.git", .upToNextMajor(from: "3.2.0"))
    ]
)
