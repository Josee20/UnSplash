//
//  PhotoLikeCollectionViewCell.swift
//  UnSplashExample
//
//  Created by 이동기 on 8/4/25.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher
import SnapKit

public final class PhotoLikeCollectionViewCell: UICollectionViewCell {
    
    public static var identifier: String {
        return String(describing: self)
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        return button
    }()
    
    public var isSelectedLikeButton: Bool {
        return likeButton.isSelected
    }
    
    public var didTapLikeButton: ControlEvent<Void> {
        return likeButton.rx.tap
    }
    
    public var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews()
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }
    
    public func configure(urlString: String) {
        likeButton.isSelected = true
        guard let url = URL(string: urlString) else { return }
        imageView.kf.setImage(with: url)
    }
    
    public func setLikeButton(_ isSelected: Bool) {
        likeButton.isSelected = isSelected
    }
    
    private func addSubviews() {
        contentView.addSubview(imageView)
        contentView.addSubview(likeButton)
    }
    
    private func setupLayout() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        likeButton.snp.makeConstraints {
            $0.width.height.equalTo(28)
            $0.trailing.equalTo(imageView.snp.trailing).offset(-14)
            $0.bottom.equalTo(imageView.snp.bottom).offset(-16)
        }
    }
    
}
