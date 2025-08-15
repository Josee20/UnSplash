//
//  AppCoordinator.swift
//  UnSplashExample
//
//  Created by 이동기 on 2025/02/24.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    weak var delegate: CoordinatorDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .app
    
    private let container: AppDIContainer
    
    init(
        _ container: AppDIContainer,
        _ navigationController: UINavigationController
    ) {
        self.container = container
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    func start() {
        startTabBarFlow()
//        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
//        homeCoordinator.delegate = self
//        homeCoordinator.start()
//        childCoordinators.append(homeCoordinator)
    }
    
    private func startTabBarFlow() {
        let tabBarDIContainer = container.makeTabBarDIContainer()
        let tabBarCoordinator = TabBarCoordinator(tabBarDIContainer, navigationController)
        tabBarCoordinator.delegate = self
        childCoordinators.append(tabBarCoordinator)
        tabBarCoordinator.start()
    }
    
}

extension AppCoordinator: CoordinatorDelegate {
    func didFinish(childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0.type != childCoordinator.type }
        self.navigationController.viewControllers.removeAll()
    }
}
