//
//  PhotoCollectionViewController.swift
//  Presentation
//
//  Created by 이동기 on 2/7/26.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import ReactorKit

public final class PhotoCollectionsViewController: UIViewController, View {
    
    let headerView = UIView()
    
    let plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        return button
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width: CGFloat = (UIScreen.main.bounds.width - 12) / 2
        layout.itemSize = CGSize(width: width, height: width + 22)
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 4
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(PhotoCollectionCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionCollectionViewCell.identifier)
        collectionView.contentInset = .init(top: 0, left: 4, bottom: 0, right: 4)
        return collectionView
    }()
    
    public var disposeBag = DisposeBag()
    
    private var viewDidLoadPublisher = PublishRelay<Void>()
    
    public init(reactor: PhotoCollectionsReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubviews()
        self.setupLayout()
        self.viewDidLoadPublisher.accept(())
    }
    
    public func bind(reactor: PhotoCollectionsReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindAction(_ reactor: PhotoCollectionsReactor) {
        viewDidLoadPublisher
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .map { Reactor.Action.didSelectItem(index: $0.item) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(_ reactor: PhotoCollectionsReactor) {
        reactor.state
            .observe(on: MainScheduler.instance)
            .map { $0.photoCollections }
            .bind(to: self.collectionView.rx.items(
                cellIdentifier: PhotoCollectionCollectionViewCell.identifier,
                cellType: PhotoCollectionCollectionViewCell.self
            )) { (index, item, cell) in
                let savedImageUrls = item.photos.map { $0.urls.regular }
                
                cell.configure(
                    title: item.title,
                    imageUrls: savedImageUrls
                )
            }
            .disposed(by: disposeBag)
    }
    
    
    private func addSubviews() {
        view.addSubview(headerView)
        view.addSubview(collectionView)
        headerView.addSubview(plusButton)
    }
    
    private func setupLayout() {
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(56)
        }
        
        plusButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-12)
            $0.width.height.equalTo(44)
            $0.centerY.equalTo(headerView.snp.centerY)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
