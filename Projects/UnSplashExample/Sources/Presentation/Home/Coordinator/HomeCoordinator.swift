//
//  HomeCoordinator.swift
//  UnSplashExample
//
//  Created by 이동기 on 2025/02/24.
//

import UIKit

//final class HomeCoordinator: Coordinator {
//    
//    var delegate: CoordinatorDelegate?
//    var navigationController: UINavigationController
//    var childCoordinators: [Coordinator] = []
//    var type: CoordinatorType = .home
//    
//    init(navigationController: UINavigationController) {
//        self.navigationController = navigationController
//    }
//    
//    func start() {
//        let viewReactor = HomeReactor(coordinator: self)
//        let homeViewController = HomeViewController(with: viewReactor)
//        self.navigationController.pushViewController(homeViewController, animated: true)
//    }
//    
//    func showPhotoDetailViewController(photoId: String) {
//        let photoDetailReactor = PhotoDetailReactor(photoId: photoId, coordinator: self)
//        let photoDetailViewController = PhotoDetailViewController(with: photoDetailReactor)
//        self.navigationController.present(photoDetailViewController, animated: true)
//    }
//    
//    
//}
