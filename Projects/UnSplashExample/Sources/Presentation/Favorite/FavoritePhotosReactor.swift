//
//  FavoritePhotosReactor.swift
//  UnSplashExample
//
//  Created by 이동기 on 6/22/25.
//

import Foundation
import RxSwift
import ReactorKit

import Domain

final class FavoritePhotosReactor: Reactor {
    
    enum Action {
        case viewDidLoad
        case viewWillAppear
        case didSelectItem(index: Int)
        case deSelectLikeButton(index: Int)
    }
    
    enum Mutation {
        case photos(photos: [Photo])
        case showPhotoDetailViewController(index: Int)
        case removePhoto(index: Int)
    }
    
    struct State {
        var photos: [Photo] = []
        var moveEvent: MoveEvent?
    }
    
    enum MoveEvent {
        case photoDetail(photoId: String)
    }
    
    var initialState: State = State()
    
    private weak var coordinator: FavoritePhotosCoordinator?
    private let photoRepository: PhotoRepository
    
    private var page: Int = 0
    private var perPage: Int = 20
    
    init(
        coordinator: FavoritePhotosCoordinator? = nil,
        photoRepository: PhotoRepository
    ) {
        self.coordinator = coordinator
        self.photoRepository = photoRepository
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad, .viewWillAppear:
            return loadPhotos()
        case .didSelectItem(let index):
            return Observable.just(.showPhotoDetailViewController(index: index))
        case .deSelectLikeButton(let index):
            let removedPhoto = currentState.photos[index]
            return photoRepository.deletePhoto(removedPhoto)
                .asObservable()
                .flatMap { isSuccess -> Observable<Mutation> in
                    return Observable.just(.removePhoto(index: index))
                }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .photos(let photos):
            print("✅ photos.count: \(photos.count)")
            newState.photos = photos
            
        case .showPhotoDetailViewController(let index):
            let photoId = newState.photos[index].id
            newState.moveEvent = .photoDetail(photoId: photoId)
            
        case .removePhoto(let index):
            var photos = newState.photos
            photos.remove(at: index)
            newState.photos = photos
        }
        
        return newState
    }
    
    private func loadPhotos() -> Observable<Mutation> {
        photoRepository.fetchSavedPhotos()
            .asObservable()
            .flatMap { photos -> Observable<Mutation> in
                return Observable.just(.photos(photos: photos))
            }
    }
        
}
