//
//  Photo.swift
//  UnSplashExample
//
//  Created by 이동기 on 2025/02/24.
//

import Foundation

public struct Photo {
    public let id: String
    public let createdAt: String
    public let updatedAt: String
    public let width: Int
    public let height: Int
    public let color: String?
    public let blurHash: String?
    public let downloads: Int?
    public let likes: Int?
    public let likedByUser: Bool?
    public let publicDomain: Bool?
    public let description: String?
//    let exif: Exif?
//    let location: Location?
//    let tags: [Tag]?
    public let urls: PhotoUrl
//    let user: UserInfo?
    
    public init(
        id: String,
        createdAt: String,
        updatedAt: String,
        width: Int,
        height: Int,
        color: String?,
        blurHash: String?,
        downloads: Int?,
        likes: Int?,
        likedByUser: Bool?,
        publicDomain: Bool?,
        description: String?,
        urls: PhotoUrl
    ) {
        self.id = id
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.width = width
        self.height = height
        self.color = color
        self.blurHash = blurHash
        self.downloads = downloads
        self.likes = likes
        self.likedByUser = likedByUser
        self.publicDomain = publicDomain
        self.description = description
        self.urls = urls
    }
}

public struct Exif {
    public let make: String
    public let model: String
    public let name: String
    public let exposureTime: String
    public let aperture: String
    public let focalLength: String
    public let iso: Int
    
    public init(
        make: String,
        model: String,
        name: String,
        exposureTime: String,
        aperture: String,
        focalLength: String,
        iso: Int
    ) {
        self.make = make
        self.model = model
        self.name = name
        self.exposureTime = exposureTime
        self.aperture = aperture
        self.focalLength = focalLength
        self.iso = iso
    }
}

public struct Location {
    public let city: String
    public let country: String
    public let position: Position
    
    public init(
        city: String,
        country: String,
        position: Position
    ) {
        self.city = city
        self.country = country
        self.position = position
    }
}

public struct Position {
    public let latitude: Double
    public let longitude: Double
    
    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

public struct Tag {
    public let title: String
    
    public init(title: String) {
        self.title = title
    }
}

public struct UserInfo {
    public let id: String
    public let updatedAt: String
    public let username: String
    public let name: String
    public let portfolioUrl: String
    public let bio: String
    public let location: String
    public let totalLikes: Int
    public let totalPhotos: Int
    public let totalCollections: Int
    public let links: UserLinks
    
    public init(
        id: String,
        updatedAt: String,
        username: String,
        name: String,
        portfolioUrl: String,
        bio: String,
        location: String,
        totalLikes: Int,
        totalPhotos: Int,
        totalCollections: Int,
        links: UserLinks
    ) {
        self.id = id
        self.updatedAt = updatedAt
        self.username = username
        self.name = name
        self.portfolioUrl = portfolioUrl
        self.bio = bio
        self.location = location
        self.totalLikes = totalLikes
        self.totalPhotos = totalPhotos
        self.totalCollections = totalCollections
        self.links = links
    }
}

public struct UserLinks {
    public let userLink: String
    public let html: String
    public let photos: String
    public let likes: String
    public let portfolio: String
    
    public init(
        userLink: String,
        html: String,
        photos: String,
        likes: String,
        portfolio: String
    ) {
        self.userLink = userLink
        self.html = html
        self.photos = photos
        self.likes = likes
        self.portfolio = portfolio
    }
}
