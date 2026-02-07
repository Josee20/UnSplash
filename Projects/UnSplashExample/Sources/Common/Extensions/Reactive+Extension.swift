//
//  Reactive+Extension.swift
//  UnSplashExample
//
//  Created by 이동기 on 2025/02/16.
//

import RxSwift
import RxCocoa
import UIKit

//extension Reactive where Base: UICollectionView {
//    
//    
//    var heightForItemAt: DelegateProxy<UICollectionView, RxCollectionViewPinterestLayoutProxy> {
//        return
//    }
//}
//
//private final class CollectionViewPinterestLayoutNotSet: NSObject , PinterestLayoutDelegate {
//    
//    func collectionView(for collectionView: UICollectionView, heightForAtIndexPath indexPath: IndexPath) -> CGFloat {}
//}
//
//class RxCollectionViewPinterestLayoutProxy: PinterestLayoutDelegate {
//    
//    private var heightForIndexPathPublishSubject: PublishSubject<CGFloat>?
//    
//    func collectionView(for collectionView: UICollectionView, heightForAtIndexPath indexPath: IndexPath) -> CGFloat {
//        if let subject = heightForIndexPathPublishSubject {
//            subject.on(.next(indexPath2))
//        }
//    }
//    
//    
//}
