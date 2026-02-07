//
//  PhotoEntity+CoreDataClass.swift
//  UnSplashExample
//
//  Created by 이동기 on 8/3/25.
//
//

import Foundation
import CoreData

import Domain

@objc(PhotoEntity)
public class PhotoEntity: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhotoEntity> {
        return NSFetchRequest<PhotoEntity>(entityName: "PhotoEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var width: Int32
    @NSManaged public var height: Int32
    @NSManaged public var collection: PhotoCollectionEntity?

}

extension PhotoEntity {
    
    convenience init(requestDTO: PhotoRequestDTO, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = requestDTO.id
        self.imageUrl = requestDTO.imageUrl
        self.width = Int32(requestDTO.width)
        self.height = Int32(requestDTO.height)
    }

    var toDomain: Photo {
        return Photo(
            id: id ?? "",
            createdAt: "",
            updatedAt: "",
            width: Int(width),
            height: Int(height),
            color: nil,
            blurHash: nil,
            downloads: nil,
            likes: nil,
            likedByUser: nil,
            publicDomain: nil,
            description: nil,
            urls: PhotoUrl(
                raw: "",
                full: "",
                regular: imageUrl ?? "",
                small: "",
                thumb: ""
            )
        )
    }
}

extension PhotoEntity : Identifiable { }
