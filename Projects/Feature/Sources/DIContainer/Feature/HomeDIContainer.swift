//
//  HomeDIContainer.swift
//  UnSplashExample
//
//  Created by 이동기 on 8/3/25.
//

import Foundation

import Domain
import Presentation

public protocol HomeDIContainerDependency {
    func makePhotoRepository() -> PhotoRepository
}

public final class HomeDIContainer: DIContainer {
    
    private let dependency: HomeDIContainerDependency
    
    public init(dependency: HomeDIContainerDependency) {
        self.dependency = dependency
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
        return dependency.makePhotoRepository()
    }
    
}

extension HomeDIContainer: HomeCoordinatorDependency {
    public func makeHomeViewController(coordinator: HomeCoordinator) -> HomeViewController {
        return HomeViewController(
            reactor: makeHomeReactor(coordinator: coordinator)
        )
    }
    
    public func makePhotoDetailViewController(photoId: String) -> PhotoDetailViewController {
        return PhotoDetailViewController(
            reactor: makePhotoDetailReactor(photoId: photoId)
        )
    }
}
