//
//  RedditCacheService.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/11/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import Foundation
import RxSwift

class RedditCacheService: RedditCacheServiceProtocol {
    
    private let fileService: FileServiceProtocol
    
    init(fileService: FileServiceProtocol) {
        self.fileService = fileService
    }
    
    func retrieveRedditTopPostsFromCache(keyword: String) -> Single<TopPosts> {
        
        return Single.create { [weak self] observer -> Disposable in
                        
            guard let strongSelf = self else {
                observer(.error(RedditCacheServiceErrorBuilder.error(forCode: RedditCacheServiceErrorCode.ReferenceError)))
                return Disposables.create()
            }
            
            do {
            
                let path = try strongSelf.fileService.getDirectoryPath(subPath: RedditCacheConfig.cacheFolder)
                let url = path.appendingPathComponent("\(keyword).json")
                
                let jsonData = try Data(contentsOf: url)
                let top = try JSONDecoder().decode(TopPosts.self, from: jsonData)
                
                observer(.success(top))
                
            } catch {
                
                observer(.error(RedditCacheServiceErrorBuilder.error(forCode: RedditCacheServiceErrorCode.CacheMissError)))
            }
                        
            return Disposables.create()
        }
    }
    
    func storeRedditPostsInCache(keyword: String, data: Data) -> Completable {
        
        return Completable.create { [weak self] observer -> Disposable in
        
            guard let strongSelf = self else {
                observer(.error(RedditCacheServiceErrorBuilder.error(forCode: RedditCacheServiceErrorCode.ReferenceError)))
                return Disposables.create()
            }
            
            do {
        
                let path = try strongSelf.fileService.getDirectoryPath(subPath: RedditCacheConfig.cacheFolder)
                let url = path.appendingPathComponent("\(keyword).json")
                
                try data.write(to: url)
                observer(.completed)
            
            } catch {
            
                observer(.error(RedditCacheServiceErrorBuilder.error(forCode: RedditCacheServiceErrorCode.StoreCacheError)))
            }
            
            return Disposables.create()
        }
    }
    
    func invalidateLocalCache(keyword: String) -> Completable {
        
        return Completable.create { [weak self] observer -> Disposable in
            
            guard let strongSelf = self else {
                observer(.error(RedditCacheServiceErrorBuilder.error(forCode: RedditCacheServiceErrorCode.ReferenceError)))
                return Disposables.create()
            }
            
            do {
                
                let path = try strongSelf.fileService.getDirectoryPath(subPath: RedditCacheConfig.cacheFolder)
                let url = path.appendingPathComponent("\(keyword).json")
                
                try FileManager.default.removeItem(at: url)
                observer(.completed)
                
            } catch {
                
                observer(.error(RedditCacheServiceErrorBuilder.error(forCode: RedditCacheServiceErrorCode.InvalidateCacheError)))
            }
            
            return Disposables.create()
        }
    }
}
