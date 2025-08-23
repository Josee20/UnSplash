//
//  PhotoSearchCoordinator.swift
//  UnSplashExample
//
//  Created by 이동기 on 8/15/25.
//  Copyright © 2025 dklee. All rights reserved.
//

import UIKit

public protocol PhotoSearchCoordinatorDependency: AnyObject {
    func makePhotoSearchViewController(coordinator: PhotoSearchCoordinator) -> PhotoSearchViewController
    func makePhotoDetailViewController(photoId: String) -> PhotoDetailViewController
}

public final class PhotoSearchCoordinator: Coordinator {
    
    var delegate: CoordinatorDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .search
    
    private let dependency: PhotoSearchCoordinatorDependency
    
    public init(
        _ dependency: PhotoSearchCoordinatorDependency,
        _ navigationController: UINavigationController
    ) {
        self.dependency = dependency
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = dependency.makePhotoSearchViewController(coordinator: self)
        navigationController.viewControllers = [viewController]
    }
    
    func showPhotoDetailViewController(photoId: String) {
        let viewController = dependency.makePhotoDetailViewController(photoId: photoId)
        viewController.modalPresentationStyle = .overFullScreen
        navigationController.present(viewController, animated: true)
    }
    
}
