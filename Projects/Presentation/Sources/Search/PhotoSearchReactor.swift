//
//  PhotoSearchViewModel.swift
//  UnSplashExample
//
//  Created by 이동기 on 5/11/25.
//

import Foundation
import ReactorKit
import RxSwift

import Domain

public final class PhotoSearchReactor: Reactor {
    
    public var initialState: State = State()

    public enum Action {
        case viewDidLoad
        case didSearch(keyword: String)
        case didSelectItem(index: Int)
    }
    
    public enum Mutation {
        case photos(wallPaper: WallPaper)
        case setLoading(Bool)
        case showPhotoDetailViewController(index: Int)
    }
    
    public struct State {
        var photos = WallPaper(
            total: 0,
            totalPages: 0,
            results: []
        )
        var isLoading = false
    }
    
    private weak var coordinator: PhotoSearchCoordinator?
    
    private let getPhotosUseCase: GetPhotoListUseCase
    private(set) var itemsLayoutList: [PinterestLayoutItem] = []
    
    public init(
        coordinator: PhotoSearchCoordinator? = nil,
        getPhotosUseCase: GetPhotoListUseCase
    ) {
        self.coordinator = coordinator
        self.getPhotosUseCase = getPhotosUseCase
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return getPhotosUseCase.execute(title: "하늘", page: 0)
                .asObservable()
                .flatMap { wallPaper -> Observable<Mutation> in
                    self.itemsLayoutList = wallPaper.results.map { PinterestLayoutItem(aspect: CGFloat($0.height) / CGFloat($0.width))}
                    
                    return Observable.concat([
                        Observable.just(.setLoading(true)),
                        Observable.just(.photos(wallPaper: wallPaper)),
                        Observable.just(.setLoading(false))
                    ])
                }
        case .didSearch(let keyword):
            return getPhotosUseCase.execute(title: keyword, page: 0)
                .asObservable()
                .flatMap { wallPaper -> Observable<Mutation> in
                    return Observable.concat([
                        Observable.just(.setLoading(true)),
                        Observable.just(.photos(wallPaper: wallPaper)),
                        Observable.just(.setLoading(false))
                    ])
                }
            
        case .didSelectItem(let index):
            return Observable.just(.showPhotoDetailViewController(index: index))
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .photos(let wallPaper):
            newState.photos = wallPaper
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        case .showPhotoDetailViewController(let index):
            let photoId = newState.photos.results[index].id
            coordinator?.showPhotoDetailViewController(photoId: photoId)
        }
        
        return newState
    }
}
