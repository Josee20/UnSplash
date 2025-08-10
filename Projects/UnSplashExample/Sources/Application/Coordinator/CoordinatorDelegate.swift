//
//  CoordinatorDelegate.swift
//  UnSplashExample
//
//  Created by 이동기 on 2025/02/24.
//

import Foundation

protocol CoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
}
