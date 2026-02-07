//
//  PhotoRequestDTO.swift
//  UnSplashExample
//
//  Created by 이동기 on 7/23/25.
//

import Foundation

struct PhotoRequestDTO: Encodable {
    let id: String
    let imageUrl: String
    let width: Int
    let height: Int
}
