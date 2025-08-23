//
//  DiskCacheStorage.swift
//  UnSplashExample
//
//  Created by 이동기 on 2025/01/05.
//

import UIKit

//class DiskCacheStorage {
//    
//    static let shared = DiskCacheStorage()
//    private let fileManager = FileManager.default
//    
//    private init() { }
//    
//    func loadImage(_ url: URL) -> UIImage? {
//        if let filePath = checkPath(url),
//           fileManager.fileExists(atPath: filePath) {
//            print("Load image from Disk")
//            return UIImage(contentsOfFile: filePath)
//        }
//        
//        return nil
//    }
//    
//    func saveImage(
//        image: UIImage,
//        imageUrl: URL,
//        _ option: CacheOption
//    ) {
//        if option == .onlyMemory || option == .nothing {
//            return
//        }
//        
//        if let filePath = checkPath(imageUrl) {
////            if fileManager.fileExists(atPath: filePath) == false {
//                if fileManager.createFile(
//                    atPath: filePath,
//                    contents: image.jpegData(compressionQuality: 0.4)
//                ) {
//                    
//                } else {
//                    
//                }
////            }
//        }
//    }
//    
//    private func checkPath(_ imageUrl: URL) -> String? {
//        let key = imageUrl.absoluteString
//        let documentURL = try? fileManager.url(
//            for: .cachesDirectory,
//            in: .userDomainMask,
//            appropriateFor: imageUrl,
//            create: true
//        )
//        let fileURL = documentURL?.appending(path: key)
////        print("FileURL: \(fileURL)")
////        print("FileURL Path: \(fileURL?.path())")
//        return fileURL?.path()
//    }
//}
