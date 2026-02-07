//
//  AppDIContainer.swift
//  UnSplashExample
//
//  Created by 이동기 on 8/3/25.
//

import UIKit

import Data
import Presentation
import Domain

public final class AppDIContainer: DIContainer {

    public override init() { }
    
    public func makeCoreDataStorage() -> CoreDataStorage {
        return shared { CoreDataStorage.shared }
    }
    
    public func makeTabBarDIContainer() -> TabBarDIContainer {
        return TabBarDIContainer(dependency: self)
    }
    
    public func makePhotoService() -> NetworkService {
        return shared { NetworkService() }
    }
    
    public func makePhotosStorage() -> CoreDataPhotosStorage {
        return shared {
            CoreDataPhotosStorage(
                coreDataStorage: makeCoreDataStorage()
            )
        }
    }
}

extension AppDIContainer: TabBarDIContainerDependency {
    // 변경사항이 생겼을 때 수정을 최소화 하고 유연성을 높이려면 FeatureDIContainer가 아닌 AppDIContainer에서
    // repository 구현체를 주입하는게 유지보수 비용을 줄일 수 있음
    public func makePhotoRepository() -> PhotoRepository {
        return shared {
            DefaultPhotoRepository(
                photoService: makePhotoService(),
                photosStorage: makePhotosStorage()
            )
        }
    }
}

extension AppDIContainer: AppCoordinatorDependency {
    public func makeTabBarCoordinator() -> TabBarCoordinator {
        return TabBarCoordinator(makeTabBarDIContainer())
    }
}
