//
//  PhotoDetailViewController.swift
//  UnSplashExample
//
//  Created by 이동기 on 2025/02/24.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa
import RxRelay
import SnapKit

public final class PhotoDetailViewController: UIViewController, View {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let saveButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Save"
        let button = UIButton(configuration: config)
        return button
    }()
    
    private var initialTouchPoint: CGPoint = .zero
    
    public var disposeBag = DisposeBag()
    
    private let viewDidLoadPublisher = PublishRelay<Void>()
    
    public init(reactor: PhotoDetailReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("❌ \(type(of: self)) is deinitialized")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.addPanGesture()
        self.addSubviews()
        self.setupLayout()
        self.viewDidLoadPublisher.accept(())
    }
    
    private func addPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let touchPoint = gesture.location(in: view?.window)
        
        switch gesture.state {
        case .began:
            initialTouchPoint = touchPoint
            
        case .changed:
            let deltaY = touchPoint.y - initialTouchPoint.y
            if deltaY > 0 {
                self.view.frame.origin.y = deltaY
            }
            
        case .ended, .cancelled:
            let deltaY = touchPoint.y - initialTouchPoint.y
            if deltaY > 150 {
                dismiss(animated: true, completion: nil)
            } else {
                // 복원
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin.y = 0
                }
            }
            
        default:
            break
        }
    }
    
    public func bind(reactor: PhotoDetailReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindAction(_ reactor: PhotoDetailReactor) {
        viewDidLoadPublisher
            .map { PhotoDetailReactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        saveButton.rx.tap
            .map { PhotoDetailReactor.Action.didTapSaveButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(_ reactor: PhotoDetailReactor) {
        reactor.state
            .observe(on: MainScheduler.instance)
            .map { $0.photo }
            .bind(with: self) { (self, photo) in
                guard let imageUrlStr = photo?.urls.regular,
                      let imageUrl = URL(string: imageUrlStr) else { return }
                self.imageView.kf.setImage(with: imageUrl)
            }
            .disposed(by: disposeBag)
    }
    
    private func addSubviews() {
        view.addSubview(imageView)
        view.addSubview(saveButton)
    }
    
    private func setupLayout() {
        imageView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(40)
        }
        
        saveButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(40)
            $0.height.equalTo(40)
            $0.width.greaterThanOrEqualTo(60)
        }
    }
}
