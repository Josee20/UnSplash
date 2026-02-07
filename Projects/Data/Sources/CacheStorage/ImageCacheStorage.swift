//
//  CacheStorage.swift
//  UnSplashExample
//
//  Created by 이동기 on 2024/12/22.
//

import UIKit

//enum CacheOption {
//    case onlyMemory
//    case onlyDisk
//    case both
//    case nothing
//}
//
//final class ImageCacheStorage {
//    
//    static let shared = ImageCacheStorage()
//    
//    private init() { }
//    
//    private let memoryCache: NSCache = NSCache<NSString, UIImage>()
//    
//    private func save(
//        image: UIImage,
//        imageUrl: URL?,
//        option: CacheOption
//    ) {
//        if (option == .nothing || option == .onlyDisk) {
//            return
//        }
//        
//        if let url = imageUrl {
//            let key = NSString(string: url.absoluteString)
//            memoryCache.setObject(image, forKey: key)
//            print("Save image in memory")
//        }
//    }
//    
//    func getImage(imageUrl: String) -> UIImage {
//        let key = NSString(string: imageUrl)
//        
//        if let image = memoryCache.object(forKey: key) {
//            return image
//        }
//        
//        return UIImage()
//    }
//    
//    func deleteImage(imageUrl: NSString) {
//        memoryCache.removeObject(forKey: imageUrl)
//    }
//    
//    func updateImage(imageUrl: NSString) {
//        memoryCache.setObject(UIImage(), forKey: imageUrl)
//    }
//    
//    func loadImage(
//        _ imageUrl: URL?,
//        _ option: CacheOption = .both,
//        completion: @escaping (UIImage?) -> Void
//    ) {
//        guard let url = imageUrl else {
//            completion(nil)
//            return
//        }
//        
//        let key = NSString(string: url.absoluteString)
//        
//        if let cachedImage = memoryCache.object(forKey: key) {
//            completion(cachedImage)
//            return
//        }
//        
//        if let cachedImage = DiskCacheStorage.shared.loadImage(url) {
//            self.save(
//                image: cachedImage,
//                imageUrl: url,
//                option: option
//            )
//            completion(cachedImage)
//            return
//        }
//        
//        self.downloadImage(url: url) { imageData in
//            if let imageData = imageData,
//               let image = UIImage(data: imageData) {
////                print("Download the image")
//                
//                self.save(
//                    image: image,
//                    imageUrl: url,
//                    option: option
//                )
//                
//                DiskCacheStorage.shared.saveImage(image: image, imageUrl: url, option)
//                completion(image)
//            } else {
//                print("Can't Download Image.")
//                completion(nil)
//            }
//        }
//    }
//    
//    private func downloadImage(url: URL, completion: @escaping (Data?) -> Void) {
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            DispatchQueue.main.async {
//                guard error == nil else {
//                    completion(nil)
//                    return
//                }
//                
//                guard let data = data else {
//                    completion(nil)
//                    return
//                }
//                
//                guard let response = response as? HTTPURLResponse else {
//                    completion(nil)
//                    return
//                }
//                
//                completion(data)
//            }
//        }.resume()
//            
//    }
//    
//}
