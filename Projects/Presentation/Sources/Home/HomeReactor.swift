//
//  ViewReactor.swift
//  UnSplashExample
//
//  Created by 이동기 on 2024/12/15.
//

import Foundation
import ReactorKit
import RxSwift

import Domain

struct PinterestLayoutItem {
    let id: UUID = UUID()
    let aspect: CGFloat // height / width
}

public final class HomeReactor: Reactor {
    
    public var initialState: State = State()

    public enum Action {
        case viewDidLoad
        case didSelectItem(index: Int)
    }
    
    public enum Mutation {
        case photos(photos: [Photo])
        case setLoading(Bool)
        case showPhotoDetailViewController(index: Int)
    }
    
    public struct State {
        var photos: [Photo] = []
        var isLoading = false
    }
    
    enum MoveEvent {
        case photoDetail(photoId: String)
    }
    
    private weak var coordinator: HomeCoordinator?
    
    private let getPhotosUseCase: GetPhotoListUseCase
    private(set) var itemsLayoutList: [PinterestLayoutItem] = []
    private var page: Int = 0
    private var perPage: Int = 20
    
    public init(
        coordinator: HomeCoordinator? = nil,
        getPhotosUseCase: GetPhotoListUseCase
    ) {
        self.coordinator = coordinator
        self.getPhotosUseCase = getPhotosUseCase
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return getPhotosUseCase.executeRandom(page: page, perPage: perPage)
                .asObservable()
                .flatMap { photos -> Observable<Mutation> in
                    self.itemsLayoutList = photos.map { PinterestLayoutItem(aspect: CGFloat($0.height) / CGFloat($0.width))}
                    return Observable.concat([
                        Observable.just(.setLoading(true)),
                        Observable.just(.photos(photos: photos)),
                        Observable.just(.setLoading(false))
                    ])
                }
            
//            return getPhotosUseCase.execute(title: "하늘", page: 0)
//                .asObservable()
//                .flatMap { wallPaper -> Observable<Mutation> in
//                    self.itemsLayoutList = wallPaper.results.map { PinterestLayoutItem(aspect: CGFloat($0.height) / CGFloat($0.width))}
//                    
//                    return Observable.concat([
//                        Observable.just(.setLoading(true)),
//                        Observable.just(.photos(wallPaper: wallPaper)),
//                        Observable.just(.setLoading(false))
//                    ])
//                }
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
            let photoId = newState.photos[index].id
            print("✅ selected photoID: \(photoId)")
            coordinator?.showPhotoDetailViewController(photoId: photoId)
        }
        
        return newState
    }
    
}
