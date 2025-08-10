//
//  HomeDIContainer.swift
//  UnSplashExample
//
//  Created by 이동기 on 8/3/25.
//

import Foundation

protocol HomeDIContainerDependency {
    func makePhotoDetailViewController(photoId: String) -> PhotoDetailViewController
}

final class HomeDIContainer: DIContainer {
    
    private let dependency: TabBarDIContainerDependency
    
    init(dependency: TabBarDIContainerDependency) {
        self.dependency = dependency
    }
    
    func makeHomeViewController() -> HomeViewController {
        return HomeViewController(
            dependency: self,
            reactor: makeHomeReactor()
        )
    }
    
    // MARK: - Reactor
    private func makeHomeReactor() -> HomeReactor {
        return HomeReactor(
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

extension HomeDIContainer: HomeDIContainerDependency {
    func makePhotoDetailViewController(photoId: String) -> PhotoDetailViewController {
        return PhotoDetailViewController(
            reactor: makePhotoDetailReactor(photoId: photoId)
        )
    }
}
