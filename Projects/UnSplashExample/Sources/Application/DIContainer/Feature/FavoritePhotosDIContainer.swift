//
//  FavoriteDIContainer.swift
//  UnSplashExample
//
//  Created by 이동기 on 8/3/25.
//

import Foundation

final class FavoritePhotosDIContainer: DIContainer {
    
    private let dependency: TabBarDIContainerDependency
    
    init(dependency: TabBarDIContainerDependency) {
        self.dependency = dependency
    }
    
    func makeFavoritePhotosViewController() -> FavoritePhotosViewController {
        return FavoritePhotosViewController(
            reactor: makeFavoritePhotosReactor()
        )
    }
    
    // MARK: - Reactor
    private func makeFavoritePhotosReactor() -> FavoritePhotosReactor {
        return FavoritePhotosReactor(
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
