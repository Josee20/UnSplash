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
    
    private let dependency: TabBarDIContainerDependency

    init(dependency: TabBarDIContainerDependency) {
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

// MARK: - Dependency 공통 메소드
extension TabBarDIContainer {
    /// `Dependency`
    ///  - HomeDIContainerDependency
    ///  - PhotoSearchDIContainerDependency
    ///  - FavoritePhotosDIContainerDependency
    func makePhotoService() -> NetworkService {
        return dependency.makePhotoService()
    }
    
    func makePhotosStorage() -> CoreDataPhotosStorage {
        return dependency.makePhotosStorage()
    }
}

extension TabBarDIContainer: HomeDIContainerDependency {}

extension TabBarDIContainer: PhotoSearchDIContainerDependency {}

extension TabBarDIContainer: FavoritePhotosDIContainerDependency {}
