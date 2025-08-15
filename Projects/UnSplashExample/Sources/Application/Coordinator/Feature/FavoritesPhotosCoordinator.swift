//
//  FavoritesCoordinator.swift
//  UnSplashExample
//
//  Created by 이동기 on 8/15/25.
//  Copyright © 2025 dklee. All rights reserved.
//

import UIKit

protocol FavoritePhotosCoordinator: Coordinator {
    
}

final class DefaultFavoritePhotosCoordinator: FavoritePhotosCoordinator {
    
    var delegate: CoordinatorDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .favorite
    
    private let container: FavoritePhotosDIContainer
    
    init(
        _ container: FavoritePhotosDIContainer,
        _ navigationController: UINavigationController
    ) {
        self.container = container
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = container.makeFavoritePhotosViewController(coordinator: self)
        navigationController.viewControllers = [viewController]
    }

}
