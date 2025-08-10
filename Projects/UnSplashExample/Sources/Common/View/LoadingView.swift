//
//  LoadingView.swift
//  UnSplashExample
//
//  Created by 이동기 on 2025/02/23.
//

import UIKit
import SnapKit

protocol Loadable where Self: UIViewController {
    var loadingView: LoadingView { get set }
}

extension Loadable {
    
    func showLoadingView() {
        view.addSubview(loadingView)
        
        loadingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        loadingView.start()
    }
    
    func hideLoadingView() {
        loadingView.stop()
        loadingView.removeFromSuperview()
    }
}


final class LoadingView: UIView {
    
    private let indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.color = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.65)
        self.addSubview(indicatorView)
        indicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start() {
        indicatorView.startAnimating()
    }
    
    func stop() {
        indicatorView.stopAnimating()
    }
    
}
