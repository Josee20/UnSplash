//
//  MainTabBarController.swift
//  UnSplashExample
//
//  Created by 이동기 on 5/11/25.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    enum TabBar: CaseIterable {
        case home
        case search
        case favorites
    }
    
    private let tabBarDIContainer: TabBarDIContainer
    
    init(tabBarDIContainer: TabBarDIContainer) {
        self.tabBarDIContainer = tabBarDIContainer
        super.init(nibName: nil, bundle: nil)
        self.configure(tabBar: TabBar.allCases)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("❌ \(type(of: self)) is deinitialized")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBar()
        self.extendedLayoutIncludesOpaqueBars = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // 강제로 safeAreaInsets.bottom = 0 처리
        if let selectedVC = selectedViewController {
            selectedVC.additionalSafeAreaInsets.bottom = 0
        }
    }
    
    
    private func configure(tabBar: [TabBar]) {
        let viewControllers = tabBar.map { createTabNavigationController($0) }
        self.viewControllers = viewControllers
    }
    
    private func createTabNavigationController(_ tab: TabBar) -> UINavigationController {
        switch tab {
        case .home:
            let homeDIContainer = tabBarDIContainer.makeHomeDIContainer()
            let homeViewController = homeDIContainer.makeHomeViewController()
            let navigationController = UINavigationController(rootViewController: homeViewController)
            navigationController.setNavigationBarHidden(true, animated: false)
            navigationController.tabBarItem = self.configureTabBarItem(tab)
            return navigationController
        case .search:
            let photoSearchDIContainer = tabBarDIContainer.makePhotoSearchDIContainer()
            let photoSearchViewController = photoSearchDIContainer.makePhotoSearchViewController()
            let navigationController = UINavigationController(rootViewController: photoSearchViewController)
            navigationController.setNavigationBarHidden(true, animated: false)
            navigationController.tabBarItem = self.configureTabBarItem(tab)
            return navigationController
        case .favorites:
            let favoritePhotosDIContainer = tabBarDIContainer.makeFavoritePhotosDIContainer()
            let favoritePhotosViewController = favoritePhotosDIContainer.makeFavoritePhotosViewController()
            let navigationController = UINavigationController(rootViewController: favoritePhotosViewController)
            navigationController.setNavigationBarHidden(true, animated: false)
            navigationController.tabBarItem = self.configureTabBarItem(tab)
            return navigationController
        }
    }
    
    private func configureTabBarItem(_ tabBar: TabBar) -> UITabBarItem {
        switch tabBar {
        case .home:
            let tabBarItem = UITabBarItem(
                title: nil,
                image: UIImage(systemName: "house"),
                selectedImage: UIImage(systemName: "house.fill")
            )
            return tabBarItem
        case .search:
            let tabBarItem = UITabBarItem(
                title: nil,
                image: UIImage(systemName: "magnifyingglass"),
                selectedImage: UIImage(systemName: "magnifyingglass")
            )
            return tabBarItem
        case .favorites:
            let tabBarItem = UITabBarItem(
                title: nil,
                image: UIImage(systemName: "heart"),
                selectedImage: UIImage(systemName: "heart.fill")
            )
            return tabBarItem
        }
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .systemBackground
        tabBar.isTranslucent = false
    }
    
}
