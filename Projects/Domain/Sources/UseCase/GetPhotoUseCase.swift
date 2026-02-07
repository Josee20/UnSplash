//
//  GetPhotoUseCase.swift
//  UnSplashExample
//
//  Created by 이동기 on 2025/02/24.
//

import Foundation
import RxSwift

public protocol GetPhotoUseCase {
    func execute(photoId: String) -> Single<Photo>
}

public final class DefaultGetPhotoUseCase: GetPhotoUseCase {
    private let photoRepository: PhotoRepository
    
    public init(photoRepository: PhotoRepository) {
        self.photoRepository = photoRepository
    }
    
    public func execute(photoId: String) -> Single<Photo> {
        return photoRepository.fetchPhoto(photoId: photoId)
    }
}
