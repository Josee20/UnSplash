//
//  Project+Scheme.swift
//  ProjectDescriptionHelpers
//
//  Created by 이동기 on 8/9/25.
//

import ProjectDescription

public enum BuildTarget: String {
    case debug = "Debug"
    case release = "Release"
    
    public var configurationName: ConfigurationName {
        return ConfigurationName.configuration(self.rawValue)
    }
    
    public var xcconfigName: String {
        switch self {
        case .debug:
            return "Debug"
        case .release:
            return "Release"
        }
    }
}

extension Path {
    public static func relativeToXCConfig(type: BuildTarget) -> Self {
        return .relativeToRoot("./\(type.xcconfigName).xcconfig")
    }
}

extension Configuration {
    public static func build(_ type: BuildTarget, name: String = "") -> Self {
        let buildName = type.rawValue
        switch type {
        case .debug:
            return .debug(
                name: BuildTarget.debug.configurationName,
                xcconfig: .relativeToXCConfig(type: .debug)
            )
        case .release:
            return .release(
                name: BuildTarget.release.configurationName,
                xcconfig: .relativeToXCConfig(type: .release)
            
            )
        }
    }
}
