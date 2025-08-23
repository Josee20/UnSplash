//
//  HomeCoordinator.swift
//  UnSplashExample
//
//  Created by 이동기 on 8/15/25.
//  Copyright © 2025 dklee. All rights reserved.
//

import UIKit

public protocol HomeCoordinatorDependency: AnyObject {
    func makeHomeViewController(coordinator: HomeCoordinator) -> HomeViewController
    func makePhotoDetailViewController(photoId: String) -> PhotoDetailViewController
}

public final class HomeCoordinator: Coordinator {
    
    var delegate: CoordinatorDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .home
    
    private let dependency: HomeCoordinatorDependency
    
    public init(
        _ dependency: HomeCoordinatorDependency,
        _ navigationController: UINavigationController
    ) {
        self.dependency = dependency
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = dependency.makeHomeViewController(coordinator: self)
        navigationController.viewControllers = [viewController]
    }
    
    public func showPhotoDetailViewController(photoId: String) {
        let viewController = dependency.makePhotoDetailViewController(photoId: photoId)
        viewController.modalPresentationStyle = .overFullScreen
        navigationController.present(viewController, animated: true)
    }
    
    
}
