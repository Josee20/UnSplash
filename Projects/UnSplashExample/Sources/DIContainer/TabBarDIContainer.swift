//
//  TabBarDIContainer.swift
//  UnSplashExample
//
//  Created by 이동기 on 8/3/25.
//

import UIKit

import Data
import HomeFeature
import SearchFeature
import CollectionFeature
import Presentation
import Domain

public protocol TabBarDIContainerDependency {
    func makePhotoRepository() -> PhotoRepository
}

public final class TabBarDIContainer {

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

extension TabBarDIContainer: HomeDIContainerDependency {
    public func makePhotoRepository() -> PhotoRepository {
        return dependency.makePhotoRepository()
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
