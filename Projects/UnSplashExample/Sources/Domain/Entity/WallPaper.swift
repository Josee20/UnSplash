//
//  WallPaper.swift
//  UnSplashExample
//
//  Created by 이동기 on 2024/12/15.
//

import Foundation

struct WallPaper {
    let total: Int
    let totalPages: Int
    let results: [PhotoResult]
    
//    init() {
//        self.total = 0
//        self.totalPages = 0
//        self.results = []
//    }
}

struct PhotoResult {
    let id: String
    let createdAt: String
    let width: Int
    let height: Int
    let color: String
    let likes: Int
    let urls: PhotoUrl
}

struct PhotoUrl {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
    
//    init() {
//        self.raw = ""
//        self.full = ""
//        self.regular = ""
//        self.small = ""
//        self.thumb = ""
//    }
}
