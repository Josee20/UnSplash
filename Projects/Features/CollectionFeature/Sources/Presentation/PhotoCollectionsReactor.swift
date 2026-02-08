//
//  PhotoCollectionReactor.swift
//  Presentation
//
//  Created by 이동기 on 2/7/26.
//

import Foundation
import RxSwift
import ReactorKit

import Domain

public struct PhotoCollectionsActions {
    let showFavoritePhotos: (String) -> Void
    
    public init(showFavoritePhotos: @escaping (String) -> Void) {
        self.showFavoritePhotos = showFavoritePhotos
    }
}

public final class PhotoCollectionsReactor: Reactor {

    public enum Action {
        case viewDidLoad
        case viewWillAppear
        case didSelectItem(index: Int)
    }

    public enum Mutation {
        case loadSavedPhotos(photos: [Photo])
        case loadPhotoCollections(collections: [PhotoCollection])
        case showFavoritePhotosViewController(at: Int)
    }

    public struct State {
        var photoCollections: [PhotoCollection] = []
        var savedPhotos: [Photo] = []
    }

    private let actions: PhotoCollectionsActions
    
    public var initialState: State = State()

    private let getSavedPhotosUseCase: GetSavedPhotosUseCase

    public init(
        actions: PhotoCollectionsActions,
        getSavedPhotosUseCase: GetSavedPhotosUseCase
    ) {
        self.actions = actions
        self.getSavedPhotosUseCase = getSavedPhotosUseCase
    }

    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad, .viewWillAppear:
            return loadSavedPhotos()
        case .didSelectItem(let index):
            return Observable.just(.showFavoritePhotosViewController(at: index))
        }
    }

    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state

        switch mutation {
        case .loadSavedPhotos(let photos):
            let allPhotoCollection = PhotoCollection(
                id: "ALL-PHOTOS",
                title: "모든 사진",
                photos: photos
            )
            newState.photoCollections = [allPhotoCollection]
        case .showFavoritePhotosViewController(let index):
            let collectionId = state.photoCollections[index].id
            actions.showFavoritePhotos(collectionId)
        case .loadPhotoCollections(let collections):
            break
        }

        return newState
    }
    
    private func loadPhotoCollections() -> Observable<Mutation> {
        getSavedPhotosUseCase.execute()
            .asObservable()
            .flatMap { photos -> Observable<Mutation> in
                return Observable.just(.loadSavedPhotos(photos: photos))
            }
    }

    private func loadSavedPhotos() -> Observable<Mutation> {
        getSavedPhotosUseCase.execute()
            .asObservable()
            .flatMap { photos -> Observable<Mutation> in
                return Observable.just(.loadSavedPhotos(photos: photos))
            }
    }

}
