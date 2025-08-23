//
//  AppCoordinator.swift
//  UnSplashExample
//
//  Created by 이동기 on 2025/02/24.
//

import UIKit

public protocol AppCoordinatorDependency: AnyObject {
    func makeTabBarCoordinator(navigationController: UINavigationController) -> TabBarCoordinator
}

public final class AppCoordinator: Coordinator {
    
    weak var delegate: CoordinatorDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .app
    
    public let dependency: AppCoordinatorDependency
    
    public init(
        _ dependency: AppCoordinatorDependency,
        _ navigationController: UINavigationController
    ) {
        self.dependency = dependency
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    public func start() {
        startTabBarFlow()
    }
    
    private func startTabBarFlow() {
        let tabBarCoordinator = dependency.makeTabBarCoordinator(navigationController: navigationController)
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
