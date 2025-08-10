//
//  Photo.swift
//  UnSplashExample
//
//  Created by 이동기 on 2025/02/24.
//

import Foundation

struct Photo {
    let id: String
    let createdAt: String
    let updatedAt: String
    let width: Int
    let height: Int
    let color: String?
    let blurHash: String?
    let downloads: Int?
    let likes: Int?
    let likedByUser: Bool?
    let publicDomain: Bool?
    let description: String?
//    let exif: Exif?
//    let location: Location?
//    let tags: [Tag]?
    let urls: PhotoUrl
//    let user: UserInfo?
    
//    init() {
//        self.id = ""
//        self.createdAt = ""
//        self.updatedAt = ""
//        self.width = 0
//        self.height = 0
//        self.color = ""
//        self.blurHash = ""
//        self.downloads = 0
//        self.likes = 0
//        self.likedByUser = false
//        self.publicDomain = false
//        self.description = ""
//        self.exif = Exif()
//        self.location = Location()
//        self.tags = []
//        self.urls = PhotoUrl()
//        self.user = UserInfo()
//    }
}

struct Exif {
    let make: String
    let model: String
    let name: String
    let exposureTime: String
    let aperture: String
    let focalLength: String
    let iso: Int
    
//    init() {
//        self.make = ""
//        self.model = ""
//        self.name = ""
//        self.exposureTime = ""
//        self.aperture = ""
//        self.focalLength = ""
//        self.iso = 0
//    }
}

struct Location {
    let city: String
    let country: String
    let position: Position
    
//    init() {
//        self.city = ""
//        self.country = ""
//        self.position = Position()
//    }
}

struct Position {
    let latitude: Double
    let longitude: Double
    
//    init() {
//        self.latitude = 0.0
//        self.longitude = 0.0
//    }
}

struct Tag {
    let title: String
}

struct UserInfo {
    let id: String
    let updatedAt: String
    let username: String
    let name: String
    let portfolioUrl: String
    let bio: String
    let location: String
    let totalLikes: Int
    let totalPhotos: Int
    let totalCollections: Int
    let links: UserLinks
    
//    init() {
//        self.id = ""
//        self.updatedAt = ""
//        self.username = ""
//        self.name = ""
//        self.portfolioUrl = ""
//        self.bio = ""
//        self.location = ""
//        self.totalLikes = 0
//        self.totalPhotos = 0
//        self.totalCollections = 0
//        self.links = UserLinks()
//    }
}

struct UserLinks {
    let userLink: String
    let html: String
    let photos: String
    let likes: String
    let portfolio: String
    
//    init() {
//        self.`self` = ""
//        self.html = ""
//        self.photos = ""
//        self.likes = ""
//        self.portfolio = ""
//    }
}

