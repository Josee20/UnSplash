//
//  FavoriteDIContainer.swift
//  UnSplashExample
//
//  Created by 이동기 on 8/3/25.
//

import Foundation

import Domain

protocol FavoritePhotosDIContainerDependency: AnyObject {
    func makePhotoService() -> NetworkService
    func makePhotosStorage() -> CoreDataPhotosStorage
}

final class FavoritePhotosDIContainer: DIContainer {
    
    private let dependency: FavoritePhotosDIContainerDependency
    
    init(dependency: FavoritePhotosDIContainerDependency) {
        self.dependency = dependency
    }
    
    func makeFavoritePhotosViewController(coordinator: FavoritePhotosCoordinator) -> FavoritePhotosViewController {
        return FavoritePhotosViewController(
            reactor: makeFavoritePhotosReactor(coordinator: coordinator)
        )
    }
    
    // MARK: - Reactor
    private func makeFavoritePhotosReactor(coordinator: FavoritePhotosCoordinator) -> FavoritePhotosReactor {
        return FavoritePhotosReactor(
            coordinator: coordinator,
            photoRepository: makePhotoRepository()
        )
    }
    
    // MARK: - Repository
    private func makePhotoRepository() -> PhotoRepository {
        return shared {
            DefaultPhotoRepository(
                photoService: dependency.makePhotoService(),
                photosStorage: dependency.makePhotosStorage()
            )
        }
    }
}
