//
//  AppCoordinator.swift
//  UnSplashExample
//
//  Created by 이동기 on 2025/02/24.
//

import UIKit
import Shared

public protocol AppCoordinatorDependency: AnyObject {
    func makeTabBarCoordinator() -> TabBarCoordinator
}

public final class AppCoordinator: Coordinator {
    
    weak public var delegate: CoordinatorDelegate?
    public var childCoordinators: [Coordinator] = []
    public var type: CoordinatorType = .app
    
    private var window: UIWindow?
    
    public let dependency: AppCoordinatorDependency
    
    public init(
        _ dependency: AppCoordinatorDependency,
        _ window: UIWindow?
    ) {
        self.dependency = dependency
        self.window = window
    }
    
    public func start() {
        startTabBarFlow()
    }
    
    private func startTabBarFlow() {
        let tabBarCoordinator = dependency.makeTabBarCoordinator()
        tabBarCoordinator.delegate = self
        childCoordinators.append(tabBarCoordinator)
        tabBarCoordinator.start()
        window?.rootViewController = tabBarCoordinator.rootViewController
        window?.makeKeyAndVisible()
    }
    
}

extension AppCoordinator: CoordinatorDelegate {
    public func didFinish(childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0.type != childCoordinator.type }
    }
}
