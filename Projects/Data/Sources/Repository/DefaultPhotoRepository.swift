//
//  PhotoRepository.swift
//  UnSplashExample
//
//  Created by 이동기 on 2024/12/15.
//

import Foundation
import RxSwift

import Domain

public final class DefaultPhotoRepository: PhotoRepository {
    
    private let photoService: NetworkService
    private let photosStorage: CoreDataPhotosStorage
    
    public init(photoService: NetworkService, photosStorage: CoreDataPhotosStorage) {
        self.photoService = photoService
        self.photosStorage = photosStorage
    }
    
    public func fetchPhotos(title: String, page: Int) -> Single<WallPaper> {
        let router = UnSplashAPIRouter<WallPaperResponseDTO>.searchPhoto(query: title, page: page)
        return photoService.request(router: router).map { $0.toDomain }
    }
    
    public func fetchPhoto(photoId id: String) -> Single<Photo> {
        let router = UnSplashAPIRouter<PhotoResponseDTO>.singlePhoto(photoId: id)
        return photoService.request(router: router).map { $0.toDomain }
    }
    
    public func fetchRandomPhotos(page: Int, perPage: Int) -> Single<[Photo]> {
        let router = UnSplashAPIRouter<[PhotoResponseDTO]>.randomPhotos(page: page, perPage: perPage)
        return photoService.request(router: router).map { $0.map { $0.toDomain } }
    }
    
    public func fetchSavedPhotos() -> Single<[Photo]> {
        return Single.create { [weak self] single in
            self?.photosStorage.fetchPhotos { result in
                switch result {
                case .success(let photos):
                    print("✅ saved photo : \(photos)")
                    single(.success(photos.map { $0.toDomain }))
                case .failure(let error):
                    single(.failure(error))
                }
            }
        
            return Disposables.create()
        }
    }
    
    public func savePhoto(photo: Photo) -> Single<Photo> {
        let requestDto = PhotoRequestDTO(
            id: photo.id,
            imageUrl: photo.urls.regular,
            width: photo.width,
            height: photo.height
        )
        
        return Single.create { [weak self] single in
            self?.photosStorage.savePhoto(requestDto) { result in
                switch result {
                case .success(let photoEntity):
                    print("Photo save response: \(photoEntity)")
                    single(.success(photoEntity.toDomain))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            
            return Disposables.create()
        }
    }
    
    public func deletePhoto(_ photo: Photo) -> Single<Bool> {
        let requestDto = PhotoRequestDTO(
            id: photo.id,
            imageUrl: photo.urls.regular,
            width: photo.width,
            height: photo.height
        )
        
        return Single.create { [weak self] single in
            self?.photosStorage.delete(requestDto) { result in
                switch result {
                case .success:
                    single(.success(true))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            
            return Disposables.create()
        }
    }

}
