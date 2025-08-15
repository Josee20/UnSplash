//
//  AppDIContainer.swift
//  UnSplashExample
//
//  Created by 이동기 on 8/3/25.
//

import Foundation

final class AppDIContainer: DIContainer {

    override init() { }
    
    private func makeCoreDataStorage() -> CoreDataStorage {
        return shared { CoreDataStorage.shared }
    }
    
    func makeTabBarDIContainer() -> TabBarDIContainer {
        return TabBarDIContainer(dependency: self)
    }
    
}

extension AppDIContainer: TabBarDIContainerDependency {
    func makePhotoService() -> NetworkService {
        return shared { NetworkService() }
    }
    
    func makePhotosStorage() -> CoreDataPhotosStorage {
        return shared {
            CoreDataPhotosStorage(
                coreDataStorage: makeCoreDataStorage()
            )
        }
    }
    
    
}
