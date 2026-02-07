//
//  GetPhotosUseCase.swift
//  UnSplashExample
//
//  Created by 이동기 on 2024/12/15.
//

import Foundation
import RxSwift

public protocol GetPhotoListUseCase {
    func execute(title: String, page: Int) -> Single<WallPaper>
    func executeRandom(page: Int, perPage: Int) -> Single<[Photo]> 
}

public final class DefaultGetPhotoListUseCase: GetPhotoListUseCase {
    private let photoRepository: PhotoRepository
    
    public init(photoRepository: PhotoRepository) {
        self.photoRepository = photoRepository
    }
    
    public func execute(title: String, page: Int) -> Single<WallPaper> {
        return photoRepository.fetchPhotos(title: title, page: page)
    }
    
    public func executeRandom(page: Int, perPage: Int) -> Single<[Photo]> {
        return photoRepository.fetchRandomPhotos(page: page, perPage: perPage)
    }
    
    

}
