//
//  SceneDelegate.swift
//  SearchDemoApp
//
//  Created by 이동기 on 2/9/26.
//

import UIKit
import SearchFeature

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var photoSearchCoordinator: PhotoSearchCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let appDIContainer = AppDIContainer()
        let photoSearchDIContainer = PhotoSearchDIContainer(dependency: appDIContainer)
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        photoSearchCoordinator = PhotoSearchCoordinator(photoSearchDIContainer, navigationController)
        photoSearchCoordinator?.start()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }

}
