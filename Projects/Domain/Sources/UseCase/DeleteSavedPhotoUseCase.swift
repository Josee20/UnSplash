//
//  DeleteSavedPhotoUseCase.swift
//  UnSplashExample
//
//  Created by 이동기 on 2/7/26.
//

import Foundation
import RxSwift

public protocol DeleteSavedPhotoUseCase {
    func execute(_ photo: Photo) -> Single<Bool>
}

public final class DefaultDeleteSavedPhotoUseCase: DeleteSavedPhotoUseCase {

    private let photoRepository: PhotoRepository

    public init(photoRepository: PhotoRepository) {
        self.photoRepository = photoRepository
    }

    public func execute(_ photo: Photo) -> Single<Bool> {
        return photoRepository.deletePhoto(photo)
    }
}
