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

public final class HomeDIContainer {

    private let dependency: HomeDIContainerDependency

    public init(dependency: HomeDIContainerDependency) {
        self.dependency = dependency
    }
    
    // MARK: - Reactor
    private func makeHomeReactor(actions: HomeActions) -> HomeReactor {
        return HomeReactor(
            actions: actions,
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
        return DefaultGetPhotoUseCase(
            photoRepository: makePhotoRepository()
        )
    }

    private func makeGetPhotoListUseCase() -> GetPhotoListUseCase {
        return DefaultGetPhotoListUseCase(
            photoRepository: makePhotoRepository()
        )
    }

    private func makeSavePhotoUseCase() -> SavePhotoUseCase {
        return DefaultSavePhotoUseCase(
            photoRepository: makePhotoRepository()
        )
    }
    
    // MARK: - Repository
    private func makePhotoRepository() -> PhotoRepository {
        return dependency.makePhotoRepository()
    }
    
}

extension HomeDIContainer: HomeCoordinatorDependency {
    public func makeHomeViewController(actions: HomeActions) -> HomeViewController {
        return HomeViewController(
            reactor: makeHomeReactor(actions: actions)
        )
    }
    
    public func makePhotoDetailViewController(photoId: String) -> PhotoDetailViewController {
        return PhotoDetailViewController(
            reactor: makePhotoDetailReactor(photoId: photoId)
        )
    }
}
