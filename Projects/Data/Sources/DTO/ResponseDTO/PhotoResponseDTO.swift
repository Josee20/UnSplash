//
//  PhotoResponseDTO.swift
//  UnSplashExample
//
//  Created by 이동기 on 2025/02/24.
//

import Foundation

import Domain

struct PhotoResponseDTO: Decodable {
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
//    let exif: ExifResponseDTO?
//    let location: LocationResponseDTO?
//    let tags: [TagResponseDTO]?
    let urls: UrlResponseDTO
//    let user: UserInfoResponseDTO?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case width, height, color
        case blurHash = "blur_hash"
        case downloads, likes
        case likedByUser = "liked_by_user"
        case publicDomain = "public_domain"
        case description
        case urls
//        case exif, location, tags, user
    }
    
    var toDomain: Photo {
        return Photo(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            width: width,
            height: height,
            color: color,
            blurHash: blurHash,
            downloads: downloads,
            likes: likes,
            likedByUser: likedByUser,
            publicDomain: publicDomain,
            description: description,
//            exif: exif?.toDomain,
//            location: location?.toDomain,
//            tags: tags?.map { $0.toDomain },
            urls: urls.toDomain,
//            user: user?.toDomain
        )
    }
}

public struct ExifResponseDTO: Decodable {
    let make: String
    let model: String
    let name: String
    let exposureTime: String
    let aperture: String
    let focalLength: String
    let iso: Int
    
    enum CodingKeys: String, CodingKey {
        case make, model, name
        case exposureTime = "exposure_time"
        case aperture
        case focalLength = "focal_length"
        case iso
    }
    
    var toDomain: Exif {
        return Exif(
            make: make,
            model: model,
            name: name,
            exposureTime: exposureTime,
            aperture: aperture,
            focalLength: focalLength,
            iso: iso
        )
    }
}

public struct LocationResponseDTO: Decodable {
    let city: String
    let country: String
    let position: PositionResponseDTO
    
    var toDomain: Location {
        return Location(
            city: city,
            country: country,
            position: position.toDomain
        )
    }
}

public struct PositionResponseDTO: Decodable {
    let latitude: Double
    let longtitude: Double
    
    var toDomain: Position {
        return Position(
            latitude: latitude,
            longitude: longtitude
        )
    }
}

public struct TagResponseDTO: Decodable {
    let title: String
    
    var toDomain: Tag {
        return Tag(title: title)
    }
}

public struct UserInfoResponseDTO: Decodable {
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
    let links: UserLinksResponseDTO
    
    enum CodingKeys: String, CodingKey {
        case id
        case updatedAt = "updated_at"
        case username, name
        case portfolioUrl = "portfolio_url"
        case bio, location
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case totalCollections = "total_collections"
        case links
    }
    
    var toDomain: UserInfo {
        return UserInfo(
            id: id,
            updatedAt: updatedAt,
            username: username,
            name: name,
            portfolioUrl: portfolioUrl,
            bio: bio,
            location: location,
            totalLikes: totalLikes,
            totalPhotos: totalPhotos,
            totalCollections: totalCollections,
            links: links.toDomain
        )
    }
}

public struct UserLinksResponseDTO: Decodable {
    let userLink: String
    let html: String
    let photos: String
    let likes: String
    let portfolio: String
    
    enum CodingKeys: String, CodingKey {
        case userLink = "self"
        case html, photos, likes, portfolio
    }
    
    var toDomain: UserLinks {
        return UserLinks(
            userLink: userLink,
            html: html,
            photos: photos,
            likes: likes,
            portfolio: portfolio
        )
    }
}
