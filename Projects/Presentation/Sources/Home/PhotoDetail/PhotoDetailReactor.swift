//
//  PhotoDetailReactor.swift
//  UnSplashExample
//
//  Created by 이동기 on 2025/02/24.
//

import ReactorKit

import Domain

public final class PhotoDetailReactor: Reactor {
    
    public enum Action {
        case viewDidLoad
        case didTapSaveButton
    }
    
    public enum Mutation {
        case photo(photo: Photo)
        case saveComplete(Bool)
    }
    
    public struct State {
        var photo: Photo?
        var saveComplete: Bool?
    }
    
    private let getPhotoUseCase: GetPhotoUseCase
    private let savePhotoUseCase: SavePhotoUseCase
    
    private let photoId: String
    
    public var initialState: State = State()
    
    public init(
        photoId: String,
        getPhotoUseCase: GetPhotoUseCase,
        savePhotoUseCase: SavePhotoUseCase
    ) {
        self.photoId = photoId
        self.getPhotoUseCase = getPhotoUseCase
        self.savePhotoUseCase = savePhotoUseCase
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return getPhotoUseCase.execute(photoId: self.photoId)
                .asObservable()
                .flatMap { photo -> Observable<Mutation> in
                    return Observable.just(.photo(photo: photo))
                }
        case .didTapSaveButton:
            guard let photo = currentState.photo else { return Observable.just(.saveComplete(false)) }
            print("✅ currentState.photo: \(currentState.photo)")
            return savePhotoUseCase.execute(photo)
                .asObservable()
                .flatMap { photo -> Observable<Mutation> in
                    return Observable.just(.saveComplete(true))
                }
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .photo(let photo):
            newState.photo = photo
        case .saveComplete:
            newState.saveComplete = true
        }
        
        return newState
    }
    
}
