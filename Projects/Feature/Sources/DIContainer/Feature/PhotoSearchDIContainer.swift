//
//  SearchDIContainer.swift
//  UnSplashExample
//
//  Created by 이동기 on 8/3/25.
//

import Foundation

import Domain
import Presentation

public protocol PhotoSearchDIContainerDependency {
    func makePhotoRepository() -> PhotoRepository
}

public final class PhotoSearchDIContainer: DIContainer {
    
    private let dependency: PhotoSearchDIContainerDependency
    
    public init(dependency: PhotoSearchDIContainerDependency) {
        self.dependency = dependency
    }
    
    // MARK: - Reactor
    private func makePhotoSearchReactor(coordinator: PhotoSearchCoordinator) -> PhotoSearchReactor {
        return PhotoSearchReactor(
            coordinator: coordinator,
            getPhotosUseCase: makeGetPhotoListUseCase()
        )
    }
    
    private func makePhotoDetailReactor(photoId: String) -> PhotoDetailReactor {
        return PhotoDetailReactor(
            photoId: photoId,
            getPhotoUseCase: makeGetPhotoUseCase(),
            savePhotoUseCase: makeSavePhotoUseCase()
        )
    }
    
    //MARK: - UseCase
    private func makeGetPhotoUseCase() -> GetPhotoUseCase {
        return shared {
            DefaultGetPhotoUseCase(
                photoRepository: makePhotoRepository()
            )
        }
    }
    
    private func makeGetPhotoListUseCase() -> GetPhotoListUseCase {
        return shared {
            DefaultGetPhotoListUseCase(
                photoRepository: makePhotoRepository()
            )
        }
    }
    
    private func makeSavePhotoUseCase() -> SavePhotoUseCase {
        return shared {
            DefaultSavePhotoUseCase(
                photoRepository: makePhotoRepository()
            )
        }
    }
    
    // MARK: - Repository
    private func makePhotoRepository() -> PhotoRepository {
        return dependency.makePhotoRepository()
    }
    
}

extension PhotoSearchDIContainer: PhotoSearchCoordinatorDependency {
    public func makePhotoSearchViewController(coordinator: PhotoSearchCoordinator) -> PhotoSearchViewController {
        return PhotoSearchViewController(
            reactor: makePhotoSearchReactor(coordinator: coordinator)
        )
    }
    
    public func makePhotoDetailViewController(photoId: String) -> PhotoDetailViewController {
        return PhotoDetailViewController(
            reactor: makePhotoDetailReactor(photoId: photoId)
        )
    }
}
