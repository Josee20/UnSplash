//
//  TabBarCoordinator.swift
//  UnSplashExample
//
//  Created by 이동기 on 8/15/25.
//  Copyright © 2025 dklee. All rights reserved.
//

import UIKit

final class TabBarCoordinator: Coordinator {
    
    enum TabBar: Int, CaseIterable {
        case home
        case search
        case favorites
        
        var title: String? {
            return nil
        }
        
        var image: UIImage? {
            switch self {
            case .home:
                return UIImage(systemName: "house")
            case .search:
                return UIImage(systemName: "magnifyingglass")
            case .favorites:
                return UIImage(systemName: "heart")
            }
        }
        
        var selectedImage: UIImage? {
            switch self {
            case .home:
                return UIImage(systemName: "house.fill")
            case .search:
                return UIImage(systemName: "magnifyingglass")
            case .favorites:
                return UIImage(systemName: "heart.fill")
            }
        }
    }
    
    var delegate: CoordinatorDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .tabBar
    
    private let container: TabBarDIContainer
    private let tabBarController: UITabBarController
    
    init(
        _ container: TabBarDIContainer,
        _ navigationContrller: UINavigationController
    ) {
        self.container = container
        self.navigationController = navigationContrller
        self.tabBarController = UITabBarController()
    }
    
    func start() {
        configure(tabBar: TabBar.allCases)
    }
    
    private func configure(tabBar: [TabBar]) {
        let navigationControllers = tabBar.map { createTabNavigationController($0) }
        self.tabBarController.setViewControllers(navigationControllers, animated: true)
        self.tabBarController.selectedIndex = TabBar.home.rawValue
        self.tabBarController.view.backgroundColor = .systemBackground
        self.tabBarController.tabBar.backgroundColor = .systemBackground
        self.tabBarController.tabBar.isTranslucent = false
        self.navigationController.pushViewController(tabBarController, animated: true)
    }
    
    private func createTabNavigationController(_ tab: TabBar) -> UINavigationController {
        let tabNavigationController = UINavigationController()
        tabNavigationController.setNavigationBarHidden(true, animated: false)
        tabNavigationController.tabBarItem = configureTabBarItem(tab)
        
        switch tab {
        case .home:
            let homeDIContainer = container.makeHomeDIContainer()
            let homeCoordinator = DefaultHomeCoordinator(homeDIContainer, tabNavigationController)
            homeCoordinator.delegate = self
            childCoordinators.append(homeCoordinator)
            homeCoordinator.start()
        case .search:
            let photoSearchDIContainer = container.makePhotoSearchDIContainer()
            let photoSearchCoordinator = DefaultPhotoSearchCoordinator(photoSearchDIContainer, tabNavigationController)
            photoSearchCoordinator.delegate = self
            childCoordinators.append(photoSearchCoordinator)
            photoSearchCoordinator.start()
        case .favorites:
            let favoritePhotosDIContainer = container.makeFavoritePhotosDIContainer()
            let favoritePhotosCoordinator = DefaultFavoritePhotosCoordinator(favoritePhotosDIContainer, tabNavigationController)
            favoritePhotosCoordinator.delegate = self
            childCoordinators.append(favoritePhotosCoordinator)
            favoritePhotosCoordinator.start()
        }
        
        return tabNavigationController
    }
    
    private func configureTabBarItem(_ tabBar: TabBar) -> UITabBarItem {
        return UITabBarItem(
            title: tabBar.title,
            image: tabBar.image,
            selectedImage: tabBar.selectedImage
        )
    }
    
}

extension TabBarCoordinator: CoordinatorDelegate {
    func didFinish(childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0.type != childCoordinator.type }
        self.navigationController.viewControllers.removeAll()
    }
}
