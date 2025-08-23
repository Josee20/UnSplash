//
//  FavoritesCoordinator.swift
//  UnSplashExample
//
//  Created by 이동기 on 8/15/25.
//  Copyright © 2025 dklee. All rights reserved.
//

import UIKit

public protocol FavoritePhotosCoordinatorDependency: AnyObject {
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
        let viewController = dependency.makeFavoritePhotosViewController(coordinator: self)
        navigationController.viewControllers = [viewController]
    }

}
