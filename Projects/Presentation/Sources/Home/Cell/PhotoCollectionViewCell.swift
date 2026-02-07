//
//  PhotoCollectionViewCell.swift
//  UnSplashExample
//
//  Created by 이동기 on 2024/12/15.
//

import UIKit
import Kingfisher
import SnapKit

final class PhotoCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(imageView)
        self.imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        imageView.kf.setImage(with: url)
    }
    
    func setImage(image: UIImage?) {
        imageView.image = image
    }
}
