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

public final class FavoritePhotosReactor: Reactor {
    
    public enum Action {
        case viewDidLoad
        case viewWillAppear
        case didSelectItem(index: Int)
        case deSelectLikeButton(index: Int)
    }
    
    public enum Mutation {
        case photos(photos: [Photo])
        case showPhotoDetailViewController(index: Int)
        case removePhoto(index: Int)
    }
    
    public struct State {
        var photos: [Photo] = []
        var moveEvent: MoveEvent?
    }
    
    enum MoveEvent {
        case photoDetail(photoId: String)
    }
    
    public var initialState: State = State()

    private weak var coordinator: FavoritePhotosCoordinator?
    private let getSavedPhotosUseCase: GetSavedPhotosUseCase
    private let deleteSavedPhotoUseCase: DeleteSavedPhotoUseCase

    public init(
        coordinator: FavoritePhotosCoordinator? = nil,
        getSavedPhotosUseCase: GetSavedPhotosUseCase,
        deleteSavedPhotoUseCase: DeleteSavedPhotoUseCase
    ) {
        self.coordinator = coordinator
        self.getSavedPhotosUseCase = getSavedPhotosUseCase
        self.deleteSavedPhotoUseCase = deleteSavedPhotoUseCase
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad, .viewWillAppear:
            return loadPhotos()
        case .didSelectItem(let index):
            return Observable.just(.showPhotoDetailViewController(index: index))
        case .deSelectLikeButton(let index):
            let removedPhoto = currentState.photos[index]
            return deleteSavedPhotoUseCase.execute(removedPhoto)
                .asObservable()
                .flatMap { _ -> Observable<Mutation> in
                    return Observable.just(.removePhoto(index: index))
                }
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .photos(let photos):
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
        getSavedPhotosUseCase.execute()
            .asObservable()
            .flatMap { photos -> Observable<Mutation> in
                return Observable.just(.photos(photos: photos))
            }
    }
        
}
