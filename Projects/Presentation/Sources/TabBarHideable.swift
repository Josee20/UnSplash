//
//  TabBarHideable.swift
//  UnSplashExample
//
//  Created by 이동기 on 6/22/25.
//

import UIKit
import RxSwift

//protocol TabBarHideable where Self: UIViewController {
//    var collectionView: UICollectionView { get set }
//    var disposeBag: DisposeBag { get set }
//}
//
//extension TabBarHideable {
//    private func handleTabBarVisibility(velocity: CGPoint) {
//        guard let tabBar = self.tabBarController?.tabBar else { return }
//        
//        if velocity.y < 0 {
//            UIView.animate(withDuration: 0.25) {
//                tabBar.alpha = 1.0
//                tabBar.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.maxY - tabBar.frame.height)
//            }
//        } else {
//            UIView.animate(withDuration: 0.25) {
//                tabBar.alpha = 0.0
//                tabBar.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.maxY)
//            }
//        }
//    }
//    
//    func bindCollectionView() {
//        collectionView.rx.willEndDragging
//            .bind(with: self) { (self, element) in
//                guard element.velocity.y != 0 else { return }
//                self.handleTabBarVisibility(velocity: element.velocity)
//            }
//            .disposed(by: disposeBag)
//    }
//}
