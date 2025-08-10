//
//  SavePhotoUseCase.swift
//  UnSplashExample
//
//  Created by 이동기 on 8/3/25.
//

import Foundation
import RxSwift

protocol SavePhotoUseCase {
    func execute(_ photo: Photo) -> Single<Photo>
}

final class DefaultSavePhotoUseCase: SavePhotoUseCase {
    
    private let photoRepository: PhotoRepository
    
    init(photoRepository: PhotoRepository) {
        self.photoRepository = photoRepository
    }
    
    func execute(_ photo: Photo) -> Single<Photo> {
        return photoRepository.savePhoto(photo: photo)
    }
    
}
