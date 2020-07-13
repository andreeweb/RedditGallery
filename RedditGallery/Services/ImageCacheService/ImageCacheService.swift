//
//  ImageCacheService.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/12/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import Foundation
import RxSwift

class ImageCacheService: ImageCacheServiceProtocol {
        
    private let fileService: FileServiceProtocol
    
    init(fileService: FileServiceProtocol) {
        self.fileService = fileService
    }
    
    func retrieveImageFromCache(imageURL: String) -> Single<UIImage> {
        
        return Single.create { [weak self] observer -> Disposable in
            
            guard let strongSelf = self else {
                observer(.error(ImageCacheServiceErrorBuilder.error(forCode: ImageCacheServiceErrorCode.ReferenceError)))
                return Disposables.create()
            }
            
            do {
                
                let localURL = strongSelf.buildLocalURLFromWebUrl(url: imageURL)
                
                let path = try strongSelf.fileService.getDirectoryPath(subPath: ImageCacheConfig.cacheFolder)
                let url = path.appendingPathComponent("\(localURL)")
                                
                let imageData = try Data(contentsOf: url)
                
                guard let uiImage: UIImage = UIImage(data: imageData) else {
                    throw ImageCacheServiceErrorBuilder.error(forCode: ImageCacheServiceErrorCode.CacheMissError)
                }
                
                observer(.success(uiImage))
                
            } catch {
                
                observer(.error(ImageCacheServiceErrorBuilder.error(forCode: ImageCacheServiceErrorCode.CacheMissError)))
            }
            
            return Disposables.create()
        }
    }
    
    func storeImageInCache(imageURL: String, image: UIImage) -> Completable {
        
        return Completable.create { [weak self] observer -> Disposable in
            
            guard let strongSelf = self else {
                observer(.error(ImageCacheServiceErrorBuilder.error(forCode: ImageCacheServiceErrorCode.ReferenceError)))
                return Disposables.create()
            }
            
            do {
                            
                let localURL = strongSelf.buildLocalURLFromWebUrl(url: imageURL)
                
                let path = try strongSelf.fileService.getDirectoryPath(subPath: ImageCacheConfig.cacheFolder)
                let url = path.appendingPathComponent("\(localURL)")
                
                guard let imageData = image.pngData() else {
                    throw ImageCacheServiceErrorBuilder.error(forCode: ImageCacheServiceErrorCode.CacheMissError)
                }
                
                try imageData.write(to: url)
                observer(.completed)
                
            } catch {
                
                observer(.error(ImageCacheServiceErrorBuilder.error(forCode: ImageCacheServiceErrorCode.StoreCacheError)))
            }
            
            return Disposables.create()
        }
    }
    
    func invalidateImageInCache(imageURL: String) -> Completable {
        
        return Completable.create { [weak self] observer -> Disposable in
            
            guard let strongSelf = self else {
                observer(.error(ImageCacheServiceErrorBuilder.error(forCode: ImageCacheServiceErrorCode.ReferenceError)))
                return Disposables.create()
            }
            
            do {
                
                let localURL = strongSelf.buildLocalURLFromWebUrl(url: imageURL)
                
                let path = try strongSelf.fileService.getDirectoryPath(subPath: ImageCacheConfig.cacheFolder)
                let url = path.appendingPathComponent("\(localURL)")
                
                try FileManager.default.removeItem(at: url)
                
                observer(.completed)
                
            } catch {
                
                observer(.error(ImageCacheServiceErrorBuilder.error(forCode: ImageCacheServiceErrorCode.InvalidateCacheError)))
            }
            
            return Disposables.create()
        }
    }
    
    private func buildLocalURLFromWebUrl(url: String) -> String {
        
        var localURL = url.replacingOccurrences(of: "https://", with: "")
        localURL = localURL.replacingOccurrences(of: "http://", with: "")
        localURL = localURL.replacingOccurrences(of: "/", with: "-")
        
        return localURL
    }
}
