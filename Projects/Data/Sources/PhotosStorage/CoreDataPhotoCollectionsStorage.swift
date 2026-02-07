//
//  CoreDataPhotoCollectionsStorage.swift
//  UnSplashExample
//
//  Created by 이동기 on 2/7/26.
//

import Foundation
import CoreData

public final class CoreDataPhotoCollectionsStorage {

    private let coreDataStorage: CoreDataStorage

    public init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }

    // MARK: - Create
    func saveCollection(
        _ requestDTO: PhotoCollectionRequestDTO,
        completion: @escaping (Result<PhotoCollectionEntity, Error>) -> Void
    ) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let entity = PhotoCollectionEntity(requestDTO: requestDTO, insertInto: context)

                let photoEntities = requestDTO.photos.map { photoDTO in
                    return PhotoEntity(
                        requestDTO: photoDTO,
                        insertInto: context
                    )
                }
                entity.photos = photoEntities

                try context.save()
                completion(.success(entity))
            } catch {
                print("❌ SaveCollection failed: \(error)")
                completion(.failure(error))
            }
        }
    }

    // MARK: - Read
    func fetchCollections(
        completion: @escaping (Result<[PhotoCollectionEntity], Error>) -> Void
    ) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let request: NSFetchRequest = PhotoCollectionEntity.fetchRequest()
                let result = try context.fetch(request)
                completion(.success(result))
            } catch {
                print("❌ FetchCollections failed: \(error)")
                completion(.failure(error))
            }
        }
    }

    // MARK: - Delete
    func deleteCollection(
        _ collectionId: String,
        completion: @escaping (Result<Bool, Error>) -> Void
    ) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let request: NSFetchRequest = PhotoCollectionEntity.fetchRequest()
                let collections = try context.fetch(request)
                collections
                    .filter { $0.id == collectionId }
                    .forEach { context.delete($0) }
                try context.save()
                completion(.success(true))
            } catch {
                print("❌ DeleteCollection failed: \(error)")
                completion(.failure(error))
            }
        }
    }
}
