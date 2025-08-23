//
//  WallPaper.swift
//  UnSplashExample
//
//  Created by 이동기 on 2024/12/15.
//

import Foundation

public struct WallPaper {
    public let total: Int
    public let totalPages: Int
    public let results: [PhotoResult]
    
    public init(
        total: Int,
        totalPages: Int,
        results: [PhotoResult]
    ) {
        self.total = total
        self.totalPages = totalPages
        self.results = results
    }
}

public struct PhotoResult {
    public let id: String
    public let createdAt: String
    public let width: Int
    public let height: Int
    public let color: String
    public let likes: Int
    public let urls: PhotoUrl
    
    public init(
        id: String,
        createdAt: String,
        width: Int,
        height: Int,
        color: String,
        likes: Int,
        urls: PhotoUrl
    ) {
        self.id = id
        self.createdAt = createdAt
        self.width = width
        self.height = height
        self.color = color
        self.likes = likes
        self.urls = urls
    }
}

public struct PhotoUrl {
    public let raw: String
    public let full: String
    public let regular: String
    public let small: String
    public let thumb: String
    
    public init(
        raw: String,
        full: String,
        regular: String,
        small: String,
        thumb: String
    ) {
        self.raw = raw
        self.full = full
        self.regular = regular
        self.small = small
        self.thumb = thumb
    }
}
