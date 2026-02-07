//
//  TabBarDIContainer.swift
//  UnSplashExample
//
//  Created by 이동기 on 8/3/25.
//

import UIKit

import Data
import Presentation
import Domain

public protocol TabBarDIContainerDependency {
//    func makePhotoService() -> NetworkService
//    func makePhotosStorage() -> CoreDataPhotosStorage
    func makePhotoRepository() -> PhotoRepository
}

public final class TabBarDIContainer: DIContainer {
    
    private let dependency: TabBarDIContainerDependency

    public init(dependency: TabBarDIContainerDependency) {
        self.dependency = dependency
    }
    
    public func makeHomeDIContainer() -> HomeDIContainer {
        return HomeDIContainer(dependency: self)
    }
    
    public func makePhotoSearchDIContainer() -> PhotoSearchDIContainer {
        return PhotoSearchDIContainer(dependency: self)
    }
    
    public func makeFavoritePhotosDIContainer() -> FavoritePhotosDIContainer {
        return FavoritePhotosDIContainer(dependency: self)
    }
    
}

// MARK: - Dependency 공통 메소드
extension TabBarDIContainer {
    /// `Dependency`
    ///  - HomeDIContainerDependency
    ///  - PhotoSearchDIContainerDependency
    ///  - FavoritePhotosDIContainerDependency
//    public func makePhotoService() -> NetworkService {
//        return dependency.makePhotoService()
//    }
//    
//    public func makePhotosStorage() -> CoreDataPhotosStorage {
//        return dependency.makePhotosStorage()
//    }
}

extension TabBarDIContainer: HomeDIContainerDependency {
    public func makePhotoRepository() -> PhotoRepository {
        return dependency.makePhotoRepository()
//            DefaultPhotoRepository(
//                photoService: dependency.makePhotoService(),
//                photosStorage: dependency.makePhotosStorage()
//            )
//        }
    }
}

extension TabBarDIContainer: PhotoSearchDIContainerDependency {}

extension TabBarDIContainer: FavoritePhotosDIContainerDependency {}

extension TabBarDIContainer: TabBarCoordinatorDependency {
    
    public func makeHomeCoordinator(navigationController: UINavigationController) -> HomeCoordinator {
        return HomeCoordinator(
            makeHomeDIContainer(),
            navigationController
        )
    }
    
    public func makePhotoSearchCoordinator(navigationController: UINavigationController) -> PhotoSearchCoordinator {
        return PhotoSearchCoordinator(
            makePhotoSearchDIContainer(),
            navigationController
        )
    }
    
    public func makeFavoritePhotosCoordinator(navigationController: UINavigationController) -> FavoritePhotosCoordinator {
        return FavoritePhotosCoordinator(
            makeFavoritePhotosDIContainer(),
            navigationController
        )
    }
    
}
