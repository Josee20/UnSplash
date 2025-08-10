//
//  AppDIContainer.swift
//  UnSplashExample
//
//  Created by 이동기 on 8/3/25.
//

import Foundation

protocol AppDIContainerDependency {
    func makeCoreDataStorage() -> CoreDataStorage
}

final class AppDIContainer: DIContainer {

    override init() { }
    
    func makeTabBarDIContainer() -> TabBarDIContainer {
        return TabBarDIContainer(dependency: self)
    }
    
}

extension AppDIContainer: AppDIContainerDependency {
    func makeCoreDataStorage() -> CoreDataStorage {
        return shared { CoreDataStorage.shared }
    }
}
