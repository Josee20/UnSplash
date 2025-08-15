//
//  HomeCoordinator.swift
//  UnSplashExample
//
//  Created by 이동기 on 8/15/25.
//  Copyright © 2025 dklee. All rights reserved.
//

import UIKit

protocol HomeCoordinator: Coordinator {
    func showPhotoDetailViewController(photoId: String)
}

final class DefaultHomeCoordinator: HomeCoordinator {
    
    var delegate: CoordinatorDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .home
    
    private let container: HomeDIContainer
    
    init(
        _ container: HomeDIContainer,
        _ navigationController: UINavigationController
    ) {
        self.container = container
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = container.makeHomeViewController(coordinator: self)
        navigationController.viewControllers = [viewController]
    }
    
    func showPhotoDetailViewController(photoId: String) {
        let viewController = container.makePhotoDetailViewController(photoId: photoId)
        viewController.modalPresentationStyle = .overFullScreen
        navigationController.present(viewController, animated: true)
    }
    
    
}
