//
//  AppDIContainer.swift
//  UnSplashExample
//
//  Created by 이동기 on 8/3/25.
//

import UIKit

import Data
import Presentation

public final class AppDIContainer: DIContainer {

    public override init() { }
    
    public func makeCoreDataStorage() -> CoreDataStorage {
        return shared { CoreDataStorage.shared }
    }
    
    public func makeTabBarDIContainer() -> TabBarDIContainer {
        return TabBarDIContainer(dependency: self)
    }
    
}

extension AppDIContainer: TabBarDIContainerDependency {
    public func makePhotoService() -> NetworkService {
        return shared { NetworkService() }
    }
    
    public func makePhotosStorage() -> CoreDataPhotosStorage {
        return shared {
            CoreDataPhotosStorage(
                coreDataStorage: makeCoreDataStorage()
            )
        }
    }
}

extension AppDIContainer: AppCoordinatorDependency {
    public func makeTabBarCoordinator(navigationController: UINavigationController) -> TabBarCoordinator {
        return TabBarCoordinator(
            makeTabBarDIContainer(),
            navigationController
        )
    }
}
