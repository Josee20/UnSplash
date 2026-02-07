//
//  PhotoCollectionCollectionViewCell.swift
//  Presentation
//
//  Created by 이동기 on 2/7/26.
//

import UIKit
import Kingfisher
import SnapKit

final class PhotoCollectionCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    private let imageView: MultipleImageView = {
        let imageView = MultipleImageView(row: 2, column: 2)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10.0
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.systemGray6.cgColor
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.systemGray6
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews()
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.resetImage()
    }
    
    func configure(title: String?, imageUrls: [String?]) {
        titleLabel.text = title
        setImage(imageUrls)
    }
    
    private func setImage(_ imageUrlStringList: [String?]) {
        guard !imageUrlStringList.isEmpty else {
            self.imageView.image = nil
            return
        }
        let imageUrls: [URL] = imageUrlStringList.compactMap { URL(string: $0 ?? "") }
        self.imageView.setImage(imageUrls: imageUrls)
    }
    
    private func addSubviews() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
    }
    
    private func setupLayout() {
        imageView.snp.makeConstraints {
            $0.leading.equalTo(contentView.snp.leading)
            $0.top.equalTo(contentView.snp.top)
            $0.trailing.equalTo(contentView.snp.trailing)
            $0.height.equalTo(contentView.snp.width)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.leading).offset(10)
            $0.top.equalTo(imageView.snp.bottom).offset(4)
            $0.trailing.equalTo(imageView.snp.trailing).inset(10)
            $0.height.equalTo(18)
            $0.bottom.equalTo(contentView.snp.bottom)
        }
    }
}

