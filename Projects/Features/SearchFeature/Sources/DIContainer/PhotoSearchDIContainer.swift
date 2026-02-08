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

public final class PhotoSearchDIContainer {

    private let dependency: PhotoSearchDIContainerDependency

    public init(dependency: PhotoSearchDIContainerDependency) {
        self.dependency = dependency
    }
    
    // MARK: - Reactor
    private func makePhotoSearchReactor(actions: PhotoSearchActions) -> PhotoSearchReactor {
        return PhotoSearchReactor(
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

extension PhotoSearchDIContainer: PhotoSearchCoordinatorDependency {
    public func makePhotoSearchViewController(actions: PhotoSearchActions) -> PhotoSearchViewController {
        return PhotoSearchViewController(
            reactor: makePhotoSearchReactor(actions: actions)
        )
    }
    
    public func makePhotoDetailViewController(photoId: String) -> PhotoDetailViewController {
        return PhotoDetailViewController(
            reactor: makePhotoDetailReactor(photoId: photoId)
        )
    }
}
