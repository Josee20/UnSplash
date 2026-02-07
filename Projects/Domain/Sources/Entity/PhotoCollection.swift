//
//  PhotoCollection.swift
//  Domain
//
//  Created by 이동기 on 2/7/26.
//

import Foundation

public struct PhotoCollection {
    public let id: String
    public let title: String
    public let photos: [Photo]
    
    public init(id: String, title: String, photos: [Photo]) {
        self.id = id
        self.title = title
        self.photos = photos
    }
}
