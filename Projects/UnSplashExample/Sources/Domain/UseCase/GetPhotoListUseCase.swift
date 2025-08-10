//
//  GetPhotosUseCase.swift
//  UnSplashExample
//
//  Created by 이동기 on 2024/12/15.
//

import Foundation
import RxSwift

protocol GetPhotoListUseCase {
    func execute(title: String, page: Int) -> Single<WallPaper>
    func executeRandom(page: Int, perPage: Int) -> Single<[Photo]> 
}

final class DefaultGetPhotoListUseCase: GetPhotoListUseCase {
    private let photoRepository: PhotoRepository
    
    init(photoRepository: PhotoRepository) {
        self.photoRepository = photoRepository
    }
    
    func execute(title: String, page: Int) -> Single<WallPaper> {
        return photoRepository.fetchPhotos(title: title, page: page)
    }
    
    func executeRandom(page: Int, perPage: Int) -> Single<[Photo]> {
        return photoRepository.fetchRandomPhotos(page: page, perPage: perPage)
    }

}
