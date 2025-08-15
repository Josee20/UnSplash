//
//  WallPaperResponseDTO.swift
//  UnSplashExample
//
//  Created by 이동기 on 2024/12/15.
//

import Foundation

import Domain

struct WallPaperResponseDTO: Decodable {
    let total: Int
    let total_pages: Int
    let results: [ResultResponseDTO]
    
    var toDomain: WallPaper {
        return WallPaper(
            total: total,
            totalPages: total_pages,
            results: results.map { $0.toDomain }
        )
    }
}

struct ResultResponseDTO: Decodable {
    let id: String
    let created_at: String
    let width: Int
    let height: Int
    let color: String
    let likes: Int
//    let liked_by_user: Bool
//    let description: String
//    let user: UserResponseDTO
    let urls: UrlResponseDTO
//    let links: LinkResponseDTO
    
    var toDomain: PhotoResult {
        return PhotoResult(
            id: id,
            createdAt: created_at,
            width: width,
            height: height,
            color: color,
            likes: likes,
            urls: urls.toDomain
        )
    }
}

struct UserResponseDTO: Decodable {
    let id: String
    let username: String
    let name: String
    let portfolio_url: String
    let profile_image: UserProfileImageResponseDTO
    let links: UserLinkResponseDTO
}

struct UserProfileImageResponseDTO: Decodable {
    let small: String
    let medium: String
    let large: String
}

struct UserLinkResponseDTO: Decodable {
    let html: String
    let photos: String
    let likes: String
}

struct UrlResponseDTO: Decodable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
    
    var toDomain: PhotoUrl {
        return PhotoUrl(
            raw: raw,
            full: full,
            regular: regular,
            small: small,
            thumb: thumb
        )
    }
}

struct LinkResponseDTO: Decodable {
    let html: String
    let download: String
}
