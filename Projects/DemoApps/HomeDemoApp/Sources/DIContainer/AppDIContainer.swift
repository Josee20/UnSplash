//
//  HomeDemoAppDIContainer.swift
//  CollectionFeatureManifests
//
//  Created by 이동기 on 2/8/26.
//

import UIKit
import Data
import HomeFeature
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

extension AppDIContainer: HomeDIContainerDependency {
    public func makePhotoRepository() -> PhotoRepository {
        return DefaultPhotoRepository(
            photoService: makePhotoService(),
            photosStorage: makePhotosStorage()
        )
    }
}
