//
//  PhotoDetailReactor.swift
//  UnSplashExample
//
//  Created by 이동기 on 2025/02/24.
//

import ReactorKit

final class PhotoDetailReactor: Reactor {
    
    enum Action {
        case viewDidLoad
        case didTapSaveButton
    }
    
    enum Mutation {
        case photo(photo: Photo)
        case saveComplete(Bool)
    }
    
    struct State {
        var photo: Photo?
        var saveComplete: Bool?
    }
    
    private let getPhotoUseCase: GetPhotoUseCase
    private let savePhotoUseCase: SavePhotoUseCase
    
    private let photoId: String
    
    var initialState: State = State()
    
    init(
        photoId: String,
        getPhotoUseCase: GetPhotoUseCase,
        savePhotoUseCase: SavePhotoUseCase
    ) {
        self.photoId = photoId
        self.getPhotoUseCase = getPhotoUseCase
        self.savePhotoUseCase = savePhotoUseCase
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
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
    
    func reduce(state: State, mutation: Mutation) -> State {
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
