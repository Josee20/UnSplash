//
//  AppDIContainer.swift
//  SearchDemoApp
//
//  Created by 이동기 on 2/9/26.
//

import UIKit
import Data
import SearchFeature
import Presentation
import Domain
import Shared

final class AppDIContainer {

    init() { }

    func makeCoreDataStorage() -> CoreDataStorage {
        return CoreDataStorage.shared
    }

    func makePhotoService() -> NetworkService {
        return  NetworkService()
    }

    func makePhotosStorage() -> CoreDataPhotosStorage {
        return CoreDataPhotosStorage(
            coreDataStorage: makeCoreDataStorage()
        )
    }

}

extension AppDIContainer: PhotoSearchDIContainerDependency {
    public func makePhotoRepository() -> PhotoRepository {
        return DefaultPhotoRepository(
            photoService: makePhotoService(),
            photosStorage: makePhotosStorage()
        )
    }
}
