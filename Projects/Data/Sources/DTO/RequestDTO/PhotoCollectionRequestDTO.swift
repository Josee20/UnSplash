//
//  PhotoCollectionRequestDTO.swift
//  Data
//
//  Created by 이동기 on 2/7/26.
//

import Foundation

struct PhotoCollectionRequestDTO: Encodable {
    let id: String = UUID().uuidString
    let title: String
    let photos: [PhotoRequestDTO]
}
