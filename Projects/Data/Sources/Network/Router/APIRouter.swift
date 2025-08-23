//
//  APIRouter.swift
//  UnSplashExample
//
//  Created by 이동기 on 2024/12/15.
//

import Foundation
import Alamofire

protocol APIRouter: URLRequestConvertible {
    associatedtype Response
    
    var baseURL: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var parameterEncoding: ParameterEncoding { get }
}

