//
//  GetSavedPhotosUseCase.swift
//  UnSplashExample
//
//  Created by 이동기 on 2/7/26.
//

import Foundation
import RxSwift

public protocol GetSavedPhotosUseCase {
    func execute() -> Single<[Photo]>
}

public final class DefaultGetSavedPhotosUseCase: GetSavedPhotosUseCase {

    private let photoRepository: PhotoRepository

    public init(photoRepository: PhotoRepository) {
        self.photoRepository = photoRepository
    }

    public func execute() -> Single<[Photo]> {
        return photoRepository.fetchSavedPhotos()
    }
}
