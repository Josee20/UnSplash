//
//  CoreDataPhotosStorage.swift
//  UnSplashExample
//
//  Created by 이동기 on 7/23/25.
//

import Foundation
import CoreData

public final class CoreDataPhotosStorage {
    
    private let coreDataStorage: CoreDataStorage
    
    public init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }
    
    func savePhoto(_ requestDTO: PhotoRequestDTO, completion: @escaping (Result<PhotoEntity, Error>) -> Void) {
        coreDataStorage.performBackgroundTask { [weak self] context in
            guard let self = self else { return }
            do {
                try self.removeDuplicates(for: requestDTO, context: context)
                let entity = PhotoEntity(requestDTO: requestDTO, insertInto: context)
                try context.save()
                completion(.success(entity))
            } catch let error {
                print("❌ Save failed: \(error)")
                completion(.failure(error))
            }
        }
    }
        
    func fetchPhotos(completion: @escaping (Result<[PhotoEntity], Error>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let request: NSFetchRequest = PhotoEntity.fetchRequest()
                let result = try context.fetch(request)
                completion(.success(result))
            } catch let error {
                print("❌ Fetch failed: \(error)")
                completion(.failure(error))
            }
        }
    }

    func delete(
        _ photo: PhotoRequestDTO,
        completion: @escaping (Result<Bool, Error>) -> Void
    ) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let request: NSFetchRequest = PhotoEntity.fetchRequest()
                let photos = try context.fetch(request)
                photos
                    .filter { $0.id == photo.id }
                    .forEach { context.delete($0) }
                try context.save()
                completion(.success(true))
            } catch let error {
                print("❌ Delete failed: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    private func removeDuplicates(for photo: PhotoRequestDTO, context: NSManagedObjectContext) throws {
        let request: NSFetchRequest = PhotoEntity.fetchRequest()
//        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(MovieQueryEntity.createdAt), ascending: false)]
        let photos = try context.fetch(request)
        photos
            .filter { $0.id == photo.id }
            .forEach { context.delete($0) }
    }
    
}
