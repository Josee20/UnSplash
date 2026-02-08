//
//  FavoritePhotosViewController.swift
//  UnSplashExample
//
//  Created by 이동기 on 5/19/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit
import Presentation

public final class FavoritePhotosViewController: UIViewController, View {

    private let navigationBarView = BaseNavigationBarView()

    lazy var collectionView: UICollectionView = {
        let layout = PinterestLayout()
        layout.delegate = self
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PhotoLikeCollectionViewCell.self, forCellWithReuseIdentifier: PhotoLikeCollectionViewCell.identifier)
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.contentInset.bottom = 12
        return collectionView
    }()
    
    public var disposeBag = DisposeBag()
    
    var viewDidLoadPublisher = PublishRelay<Void>()
    private let viewWillAppearPublisher = PublishRelay<Void>()
    private let deSelectLikeButton = PublishRelay<Int>()
    
    public init(reactor: FavoritePhotosReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.addSubviews()
        self.setupLayout()
        self.viewDidLoadPublisher.accept(())
        self.extendedLayoutIncludesOpaqueBars = true
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewWillAppearPublisher.accept(())
    }
    
    public func bind(reactor: FavoritePhotosReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindAction(_ reactor: FavoritePhotosReactor) {
        viewDidLoadPublisher
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        viewWillAppearPublisher
            .skip(1)
            .map{ Reactor.Action.viewWillAppear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        collectionView.rx.itemSelected
            .map { Reactor.Action.didSelectItem(index: $0.item) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        deSelectLikeButton
            .map { Reactor.Action.deSelectLikeButton(index: $0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        navigationBarView.backButtonDidTap
            .bind(with: self) { (self, _) in
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)

        collectionView.rx.contentOffset
            .map { offset -> CGFloat in
                let scrolled = offset.y + 56
                let alpha = max(0, 1 - scrolled / 56)
                return alpha
            }
            .bind(to: navigationBarView.rx.alpha)
            .disposed(by: disposeBag)
    }
    
    private func bindState(_ reactor: FavoritePhotosReactor) {
        reactor.state
            .map { $0.photos }
            .bind(to: self.collectionView.rx.items(
                cellIdentifier: PhotoLikeCollectionViewCell.identifier,
                cellType: PhotoLikeCollectionViewCell.self
            )) { (index, item, cell) in
                cell.configure(urlString: item.urls.regular)
                
                cell.didTapLikeButton
                    .map { cell.isSelectedLikeButton }
                    .bind(with: self) { (self, isSelected) in
                        cell.setLikeButton(!isSelected)
                        self.deSelectLikeButton.accept(index)
                    }
                    .disposed(by: cell.disposeBag)
                
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .compactMap { $0.moveEvent }
            .bind(with: self) { (self, event) in
                switch event {
                case .photoDetail(let photoId):
                    break
//                    self.showPhotoDetailViewController(photoId: photoId)
                }
            }
            .disposed(by: disposeBag)
        
    }
    
//    private func showPhotoDetailViewController(photoId: String) {
//        let photoDetailReactor = PhotoDetailReactor(photoId: photoId)
//        let photoDetailViewController = PhotoDetailViewController(with: photoDetailReactor)
//        self.navigationController?.present(photoDetailViewController, animated: true)
//    }
    
    private func addSubviews() {
        view.addSubview(collectionView)
        view.addSubview(navigationBarView)
    }

    private func setupLayout() {
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(56)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.snp.bottom)
        }

        collectionView.contentInset.top = 56
        collectionView.scrollIndicatorInsets.top = 56
    }
}

extension FavoritePhotosViewController: PinterestLayoutDelegate {
    public func collectionView(for collectionView: UICollectionView, heightForAtIndexPath indexPath: IndexPath) -> CGFloat {
        let cellWidth: CGFloat = (view.bounds.width - 4) / 2
        let height = CGFloat(reactor?.currentState.photos[indexPath.item].height ?? 0)
        let width = CGFloat(reactor?.currentState.photos[indexPath.item].width ?? 0)
        let imageAspect = height / width
        return imageAspect * cellWidth
    }
}
