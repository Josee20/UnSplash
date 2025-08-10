//
//  TabBarDIContainer.swift
//  UnSplashExample
//
//  Created by 이동기 on 8/3/25.
//

import Foundation

protocol TabBarDIContainerDependency {
    func makePhotoService() -> NetworkService
    func makePhotosStorage() -> CoreDataPhotosStorage
}

final class TabBarDIContainer: DIContainer {
    
    private let dependency: AppDIContainerDependency

    init(dependency: AppDIContainerDependency) {
        self.dependency = dependency
    }
    
    func makeHomeDIContainer() -> HomeDIContainer {
        return HomeDIContainer(dependency: self)
    }
    
    func makePhotoSearchDIContainer() -> PhotoSearchDIContainer {
        return PhotoSearchDIContainer(dependency: self)
    }
    
    func makeFavoritePhotosDIContainer() -> FavoritePhotosDIContainer {
        return FavoritePhotosDIContainer(dependency: self)
    }
    
}

extension TabBarDIContainer: TabBarDIContainerDependency {
    
    func makePhotoService() -> NetworkService {
        return shared { NetworkService() }
    }
    
    func makePhotosStorage() -> CoreDataPhotosStorage {
        return shared {
            CoreDataPhotosStorage(
                coreDataStorage: dependency.makeCoreDataStorage()
            )
        }
    }
    
}
