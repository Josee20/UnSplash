//
//  PhotoCollectionEntity+CoreDataClass.swift
//  
//
//  Created by 이동기 on 2/7/26.
//
//

import Foundation
import CoreData
import Domain

@objc(PhotoCollectionEntity)
public class PhotoCollectionEntity: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhotoCollectionEntity> {
        return NSFetchRequest<PhotoCollectionEntity>(entityName: "PhotoCollectionEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var photos: [PhotoEntity]?
    
}

extension PhotoCollectionEntity {
    
    convenience init(requestDTO: PhotoCollectionRequestDTO, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = requestDTO.id
        self.title = requestDTO.title
        self.photos = nil
    }
    
    var toDomain: PhotoCollection {
        return PhotoCollection(
            id: id ?? "",
            title: title ?? "",
            photos: photos?.compactMap { $0.toDomain } ?? []
        )
    }
}

