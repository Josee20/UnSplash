//
//  PhotoSearchViewController.swift
//  UnSplashExample
//
//  Created by 이동기 on 5/11/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit
import Presentation

public final class PhotoSearchViewController: UIViewController, View, Loadable {
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "검색어를 입력해주세요."
        return searchBar
    }()
    
    public var loadingView: LoadingView = LoadingView()
    
    lazy var collectionView: UICollectionView = {
        let layout = PinterestLayout(columnCount: 1)
        layout.delegate = self
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        return collectionView
    }()
    
    public var disposeBag = DisposeBag()
    
    var viewDidLoadPublisher = PublishRelay<Void>()
    
    public init(reactor: PhotoSearchReactor) {
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
    
    public func bind(reactor: PhotoSearchReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindAction(_ reactor: PhotoSearchReactor) {
        viewDidLoadPublisher
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        searchBar.searchTextField.rx.controlEvent(.editingDidEndOnExit)
            .map { Reactor.Action.didSearch(keyword: self.searchBar.text ?? "") }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .map { Reactor.Action.didSelectItem(index: $0.item) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(_ reactor: PhotoSearchReactor) {

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
            .map { $0.photos.results }
            .bind(to: self.collectionView.rx.items(
                cellIdentifier: PhotoCollectionViewCell.identifier,
                cellType: PhotoCollectionViewCell.self
            )) { (index, item, cell) in
                cell.setImage(urlString: item.urls.regular)
            }
            .disposed(by: disposeBag)
    }

    private func addSubviews() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }
    
    private func setupLayout() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.snp.bottom)
        }
    }
    
}

extension PhotoSearchViewController: PinterestLayoutDelegate {
    public func collectionView(for collectionView: UICollectionView, heightForAtIndexPath indexPath: IndexPath) -> CGFloat {
        let cellWidth: CGFloat = (view.bounds.width - 4)
        let imageAspect = (reactor?.itemsLayoutList[indexPath.item].aspect ?? 0.0)
        return imageAspect * cellWidth
    }
}
