//
//  PinterestLayoutItem.swift
//  Presentation
//
//  Created by 이동기 on 2/8/26.
//

import Foundation

public struct PinterestLayoutItem {
    let id: UUID = UUID()
    public let aspect: CGFloat // height / width
    
    public init(aspect: CGFloat) {
        self.aspect = aspect
    }
}
