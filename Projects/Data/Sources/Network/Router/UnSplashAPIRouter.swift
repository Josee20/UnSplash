//
//  UnSplashAPIRouter.swift
//  UnSplashExample
//
//  Created by 이동기 on 8/10/25.
//

import Foundation
import Alamofire

enum UnSplashAPIRouter<R: Decodable> {
    case searchPhoto(query: String, page: Int)
    case randomPhotos(page: Int, perPage: Int)
    case singlePhoto(photoId: String)
}

extension UnSplashAPIRouter: APIRouter {

    typealias Response = R
    
    var baseURL: URL {
        return URL(string: "https://api.unsplash.com")!
    }
    
    var method: HTTPMethod {
        switch self {
        case .searchPhoto,
                .randomPhotos,
                .singlePhoto:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .searchPhoto:
            return "/search/photos"
        case .randomPhotos:
            return "/photos"
        case .singlePhoto(let photoId):
            return "/photos/\(photoId)"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .searchPhoto(let query, let page):
            return [
                "client_id": APIKey.UnsplashKey,
                "query": query,
                "page": page
            ]
        case .randomPhotos(let page, let perPage):
            return [
                "client_id": APIKey.UnsplashKey,
                "page": page,
                "per_page": perPage
            ]
        case .singlePhoto:
            return [
                "client_id": APIKey.UnsplashKey,
            ]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .searchPhoto:
            return URLEncoding.queryString
        case .randomPhotos:
            return URLEncoding.queryString
        case .singlePhoto:
            return URLEncoding.queryString
        }
    }

    var headers: HTTPHeaders {
        switch self {
        case .searchPhoto, .randomPhotos, .singlePhoto:
//            return ["Content-Type": "application/x-www-form-urlencoded"]
            return [:]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: baseURL.appending(path: path))
        request.method = method
        request.headers = headers
        return try parameterEncoding.encode(request, with: parameters)
    }
    
}
