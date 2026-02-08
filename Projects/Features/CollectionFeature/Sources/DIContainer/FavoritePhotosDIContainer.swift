//
//  FavoriteDIContainer.swift
//  UnSplashExample
//
//  Created by 이동기 on 8/3/25.
//

import Foundation

import Presentation
import Data
import Domain

public protocol FavoritePhotosDIContainerDependency: AnyObject {
    func makePhotoRepository() -> PhotoRepository
}

public final class FavoritePhotosDIContainer {

    private let dependency: FavoritePhotosDIContainerDependency

    public init(dependency: FavoritePhotosDIContainerDependency) {
        self.dependency = dependency
    }

    // MARK: - Reactor
    private func makePhotoCollectionsReactor(actions: PhotoCollectionsActions) -> PhotoCollectionsReactor {
        return PhotoCollectionsReactor(
            actions: actions,
            getSavedPhotosUseCase: makeGetSavedPhotosUseCase()
        )
    }
    
    private func makeFavoritePhotosReactor(coordinator: FavoritePhotosCoordinator) -> FavoritePhotosReactor {
        return FavoritePhotosReactor(
            coordinator: coordinator,
            getSavedPhotosUseCase: makeGetSavedPhotosUseCase(),
            deleteSavedPhotoUseCase: makeDeleteSavedPhotoUseCase()
        )
    }

    // MARK: - UseCase
    private func makeGetSavedPhotosUseCase() -> GetSavedPhotosUseCase {
        return DefaultGetSavedPhotosUseCase(
            photoRepository: makePhotoRepository()
        )
    }

    private func makeDeleteSavedPhotoUseCase() -> DeleteSavedPhotoUseCase {
        return DefaultDeleteSavedPhotoUseCase(
            photoRepository: makePhotoRepository()
        )
    }

    // MARK: - Repository
    private func makePhotoRepository() -> PhotoRepository {
        return dependency.makePhotoRepository()
    }
}

extension FavoritePhotosDIContainer: FavoritePhotosCoordinatorDependency {
    public func makePhotoCollectionViewController(
        actions: PhotoCollectionsActions
    ) -> PhotoCollectionsViewController {
        return PhotoCollectionsViewController(
            reactor: makePhotoCollectionsReactor(actions: actions)
        )
    }
    
    public func makeFavoritePhotosViewController(
        coordinator: FavoritePhotosCoordinator
    ) -> FavoritePhotosViewController {
        return FavoritePhotosViewController(
            reactor: makeFavoritePhotosReactor(coordinator: coordinator)
        )
    }
}
