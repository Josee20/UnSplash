//
//  AppCoordinator.swift
//  UnSplashExample
//
//  Created by 이동기 on 2025/02/24.
//

import UIKit

//final class AppCoordinator: Coordinator {
//    
//    weak var delegate: CoordinatorDelegate?
//    var navigationController: UINavigationController
//    var childCoordinators: [Coordinator] = []
//    var type: CoordinatorType = .app
//    
//    init(navigationController: UINavigationController) {
//        self.navigationController = navigationController
//        navigationController.setNavigationBarHidden(true, animated: false)
//    }
//    
//    func start() {
//        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
//        homeCoordinator.delegate = self
//        homeCoordinator.start()
//        childCoordinators.append(homeCoordinator)
//    }
//    
//}
//
//extension AppCoordinator: CoordinatorDelegate {
//    func didFinish(childCoordinator: Coordinator) {
//        self.childCoordinators = self.childCoordinators.filter { $0.type != childCoordinator.type }
//        self.navigationController.viewControllers.removeAll()
//    }
//}
