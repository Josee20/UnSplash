//
//  PhotoService.swift
//  UnSplashExample
//
//  Created by 이동기 on 2024/12/15.
//

import Alamofire
import RxSwift

public final class NetworkService {
    
    public init() { }

    func request<T: Decodable, E: APIRouter>(router: E) -> Single<T> where T == E.Response {
        return Single.create { single in
            AF.request(router)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let dto):
                        single(.success(dto))
                    case .failure(let error):
                        single(.failure(error))
                    }
                }
            
            return Disposables.create()
        }
    }
    
}
