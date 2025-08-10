//
//  ViewController.swift
//  UnSplashExample
//
//  Created by 이동기 on 2024/11/18.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit

final class HomeViewController: UIViewController, View, Loadable, TabBarHideable {
 
    var loadingView: LoadingView = LoadingView()
    
    lazy var collectionView: UICollectionView = {
        let layout = PinterestLayout()
        layout.delegate = self
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        collectionView.contentInsetAdjustmentBehavior = .never
        return collectionView
    }()
    
    var disposeBag = DisposeBag()
    
    private let dependency: HomeDIContainerDependency
    var viewDidLoadPublisher = PublishRelay<Void>()
    
    init(dependency: HomeDIContainerDependency, reactor: HomeReactor) {
        self.dependency = dependency
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.bindCollectionView()
        self.addSubviews()
        self.setupLayout()
        self.viewDidLoadPublisher.accept(())
        self.extendedLayoutIncludesOpaqueBars = true
    }

    func bind(reactor: HomeReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindAction(_ reactor: HomeReactor) {
        viewDidLoadPublisher
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .map { Reactor.Action.didSelectItem(index: $0.item) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(_ reactor: HomeReactor) {

        reactor.state
            .observe(on: MainScheduler.instance)
            .map { $0.isLoading }
            .withUnretained(self)
            .bind { (self, isLoading) in
                if isLoading {
                    self.showLoadingView()
                } else {
                    self.hideLoadingView()
                }
            }
            .disposed(by: disposeBag)

        reactor.state
            .map { $0.photos }
            .bind(to: self.collectionView.rx.items(
                cellIdentifier: PhotoCollectionViewCell.identifier,
                cellType: PhotoCollectionViewCell.self
            )) { (index, item, cell) in
                cell.setImage(urlString: item.urls.regular)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .compactMap { $0.moveEvent }
            .bind(with: self) { (self, event) in
                switch event {
                case .photoDetail(let photoId):
                    self.showPhotoDetailViewController(photoId: photoId)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func showPhotoDetailViewController(photoId: String) {
        let photoDetailViewController = dependency.makePhotoDetailViewController(photoId: photoId)
        photoDetailViewController.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(photoDetailViewController, animated: true)
    }

    private func addSubviews() {
        view.addSubview(collectionView)
    }
    
    private func setupLayout() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.snp.bottom)
        }
    }
    
}

extension HomeViewController: PinterestLayoutDelegate {
    func collectionView(for collectionView: UICollectionView, heightForAtIndexPath indexPath: IndexPath) -> CGFloat {
        let cellWidth: CGFloat = (view.bounds.width - 4) / 2
        let imageAspect = (reactor?.itemsLayoutList[indexPath.item].aspect ?? 0.0)
        return imageAspect * cellWidth
    }
}
