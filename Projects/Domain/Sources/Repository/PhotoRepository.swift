//
//  PhotoRepository.swift
//  UnSplashExample
//
//  Created by 이동기 on 2024/12/15.
//

import RxSwift

public protocol PhotoRepository {
    func fetchPhotos(title: String, page: Int) -> Single<WallPaper>
    func fetchPhoto(photoId: String) -> Single<Photo>
    func fetchRandomPhotos(page: Int, perPage: Int) -> Single<[Photo]>
    func fetchSavedPhotos() -> Single<[Photo]>
    func savePhoto(photo: Photo) -> Single<Photo>
    func deletePhoto(_ photo: Photo) -> Single<Bool>
}
