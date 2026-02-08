//
//  MultipleImageView.swift
//  Presentation
//
//  Created by 이동기 on 2/7/26.
//

import UIKit
import Kingfisher

public final class MultipleImageView: UIImageView {
    
    private let row: Int
    private let column: Int
    
    public init(row: Int, column: Int) {
        self.row = row
        self.column = column
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setImage(imageUrls: [URL]) {
        guard !(imageUrls.count < (row * column)) else {
            self.kf.setImage(with: imageUrls.first)
            return
        }
        
        self.addArrangedSubviews(imageUrls)
    }
    
    private func addArrangedSubviews(_ imageUrls: [URL]) {
        let containerStackView = UIStackView()
        containerStackView.distribution = .fillEqually
        containerStackView.axis = .vertical
        containerStackView.spacing = 0.0
        
        self.addSubview(containerStackView)
        
        containerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        for i in 0..<row {
            let stackView = UIStackView()
            stackView.distribution = .fillEqually
            stackView.axis = .horizontal
            containerStackView.addArrangedSubview(stackView)
            
            for j in 0..<column {
                let imageView = UIImageView()
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
                let imageUrl = imageUrls[(i * row) + j]
                imageView.kf.setImage(with: imageUrl)
                stackView.addArrangedSubview(imageView)
            }
        }
    }
    
    public func resetImage() {
        self.subviews.forEach {
            $0.removeFromSuperview()
        }
    }

}
