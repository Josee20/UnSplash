//
//  SavePhotoUseCase.swift
//  UnSplashExample
//
//  Created by 이동기 on 8/3/25.
//

import Foundation
import RxSwift

public protocol SavePhotoUseCase {
    func execute(_ photo: Photo) -> Single<Photo>
}

public final class DefaultSavePhotoUseCase: SavePhotoUseCase {
    
    private let photoRepository: PhotoRepository
    
    public init(photoRepository: PhotoRepository) {
        self.photoRepository = photoRepository
    }
    
    public func execute(_ photo: Photo) -> Single<Photo> {
        return photoRepository.savePhoto(photo: photo)
    }
    
}
