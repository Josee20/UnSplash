//
//  GetPhotoUseCase.swift
//  UnSplashExample
//
//  Created by 이동기 on 2025/02/24.
//

import Foundation
import RxSwift

protocol GetPhotoUseCase {
    func execute(photoId: String) -> Single<Photo>
}

final class DefaultGetPhotoUseCase: GetPhotoUseCase {
    private let photoRepository: PhotoRepository
    
    init(photoRepository: PhotoRepository) {
        self.photoRepository = photoRepository
    }
    
    func execute(photoId: String) -> Single<Photo> {
        return photoRepository.fetchPhoto(photoId: photoId)
    }
}
