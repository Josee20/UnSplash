//
//  FavoritesCoordinator.swift
//  UnSplashExample
//
//  Created by 이동기 on 8/15/25.
//  Copyright © 2025 dklee. All rights reserved.
//

import UIKit

public protocol FavoritePhotosCoordinatorDependency: AnyObject {
    func makePhotoCollectionViewController(actions: PhotoCollectionsActions) -> PhotoCollectionsViewController
    func makeFavoritePhotosViewController(coordinator: FavoritePhotosCoordinator) -> FavoritePhotosViewController
}

public final class FavoritePhotosCoordinator: Coordinator {
    
    var delegate: CoordinatorDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .favorite
    
    private let dependency: FavoritePhotosCoordinatorDependency
    
    public init(
        _ dependency: FavoritePhotosCoordinatorDependency,
        _ navigationController: UINavigationController
    ) {
        self.dependency = dependency
        self.navigationController = navigationController
    }
    
    func start() {
        showPhotoCollectionsViewController()
    }

    func showPhotoCollectionsViewController() {
        let actions = PhotoCollectionsActions(
            showFavoritePhotos: { [weak self] id in
                self?.showFavoritePhotosViewController()
            }
        )
        let viewController = dependency.makePhotoCollectionViewController(actions: actions)
        navigationController.viewControllers = [viewController]
    }
    
    private func showFavoritePhotosViewController() {
        let viewController = dependency.makeFavoritePhotosViewController(coordinator: self)
        navigationController.pushViewController(viewController, animated: true)
    }
}
