import ProjectDescription
import ProjectDescriptionHelpers

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
