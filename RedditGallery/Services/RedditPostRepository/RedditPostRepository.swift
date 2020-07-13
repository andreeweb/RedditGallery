//
//  RedditPostRepository.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/11/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import Foundation
import RxSwift

class RedditPostRepository: RedditPostRepositoryProtocol {
    
    private let redditService: RedditServiceProtocol
    private let cacheService: RedditCacheServiceProtocol
    
    init(redditService: RedditServiceProtocol, cacheService: RedditCacheServiceProtocol) {
        self.redditService = redditService
        self.cacheService = cacheService
    }
    
    func getRedditPostPerKeyword(keyword: String) -> Single<TopPosts> {
        
        var requestDisposable: Disposable? = nil
        var nestedRequestDisposable: Disposable? = nil
        
        return Single.create { [weak self] observer -> Disposable in
            
            guard let strongSelf = self else {
                observer(.error(RedditPostRepositoryErrorBuilder.error(forCode: RedditPostRepositoryErrorCode.ReferenceError)))
                return Disposables.create()
            }
                        
            requestDisposable = strongSelf.redditService.retriveRedditTopPosts(keyword: keyword)
                .subscribe(onSuccess: { (posts) in
                    
                    // save data in cache
                    nestedRequestDisposable = strongSelf.cacheService.storeRedditPostsInCache(keyword: keyword, topPosts: posts)
                        .subscribe(onCompleted: {
                            
                            nestedRequestDisposable?.dispose()
                            
                        }, onError: { (error) in
                            
                            print("Repository getRedditPostPerKeyword :: \(error)")
                        })
                    
                    observer(.success(posts))
                    requestDisposable?.dispose()
                
            }, onError: { (error) in
                                                
                nestedRequestDisposable = strongSelf.cacheService.retrieveRedditTopPostsFromCache(keyword: keyword)
                    .subscribe(onSuccess: { (posts) in
                                                                        
                        observer(.success(posts))
                        nestedRequestDisposable?.dispose()
                        
                    }, onError: { (error) in
                                                
                        observer(.error(RedditPostRepositoryErrorBuilder.error(forCode: RedditPostRepositoryErrorCode.NoDataForThisKeyword)))
                    })
            })
            
            return Disposables.create()
        }
    }
}
