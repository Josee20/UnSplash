//
//  BaseNavigationBarView.swift
//  Presentation
//
//  Created by 이동기 on 2/7/26.
//

import UIKit
import SnapKit
import RxCocoa

public final class BaseNavigationBarView: UIView {

    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(
            UIImage(systemName: "chevron.left"),
            for: .normal
        )
        button.tintColor = .black
        return button
    }()
    
    public var backButtonDidTap: ControlEvent<Void> {
        return backButton.rx.tap
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(backButton)

        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(44)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 56)
    }
}
