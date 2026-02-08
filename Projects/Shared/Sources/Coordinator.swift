//
//  Coordinator.swift
//  CollectionFeatureManifests
//
//  Created by 이동기 on 2/8/26.
//

import Foundation

public enum CoordinatorType {
    case app
    case tabBar
    case home
    case search
    case favorite
}

public protocol CoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
}

public protocol Coordinator: AnyObject {
    var delegate: CoordinatorDelegate? { get set }
    var childCoordinators: [Coordinator] { get set }
    var type: CoordinatorType { get set }
    
    func start()
    func finish()
}

extension Coordinator {
    public func finish() {
        childCoordinators.removeAll()
        delegate?.didFinish(childCoordinator: self)
    }
}
