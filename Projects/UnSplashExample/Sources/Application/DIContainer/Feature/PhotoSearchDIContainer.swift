//
//  SearchDIContainer.swift
//  UnSplashExample
//
//  Created by 이동기 on 8/3/25.
//

import Foundation

import Domain

protocol PhotoSearchDIContainerDependency {
    func makePhotoService() -> NetworkService
    func makePhotosStorage() -> CoreDataPhotosStorage
}

final class PhotoSearchDIContainer: DIContainer {
    
    private let dependency: PhotoSearchDIContainerDependency
    
    init(dependency: PhotoSearchDIContainerDependency) {
        self.dependency = dependency
    }
    
    func makePhotoSearchViewController(coordinator: PhotoSearchCoordinator) -> PhotoSearchViewController {
        return PhotoSearchViewController(
            reactor: makePhotoSearchReactor(coordinator: coordinator)
        )
    }
    
    func makePhotoDetailViewController(photoId: String) -> PhotoDetailViewController {
        return PhotoDetailViewController(
            reactor: makePhotoDetailReactor(photoId: photoId)
        )
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
        return shared {
            DefaultPhotoRepository(
                photoService: dependency.makePhotoService(),
                photosStorage: dependency.makePhotosStorage()
            )
        }
    }
    
}
