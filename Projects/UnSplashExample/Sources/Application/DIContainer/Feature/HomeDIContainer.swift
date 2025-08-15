//
//  HomeDIContainer.swift
//  UnSplashExample
//
//  Created by 이동기 on 8/3/25.
//

import Foundation

import Domain

protocol HomeDIContainerDependency {
    func makePhotoService() -> NetworkService
    func makePhotosStorage() -> CoreDataPhotosStorage
}

final class HomeDIContainer: DIContainer {
    
    private let dependency: HomeDIContainerDependency
    
    init(dependency: HomeDIContainerDependency) {
        self.dependency = dependency
    }
    
    func makeHomeViewController(coordinator: HomeCoordinator) -> HomeViewController {
        return HomeViewController(
            reactor: makeHomeReactor(coordinator: coordinator)
        )
    }
    
    func makePhotoDetailViewController(photoId: String) -> PhotoDetailViewController {
        return PhotoDetailViewController(
            reactor: makePhotoDetailReactor(photoId: photoId)
        )
    }
    
    // MARK: - Reactor
    private func makeHomeReactor(coordinator: HomeCoordinator) -> HomeReactor {
        return HomeReactor(
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
