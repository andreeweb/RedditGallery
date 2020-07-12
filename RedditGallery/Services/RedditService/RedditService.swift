//
//  RedditService.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/11/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import Foundation
import RxSwift

class RedditService: RedditServiceProtocol {
    
    private var httpService: HTTPServiceProtocol
    
    init(httpService: HTTPServiceProtocol) {
        self.httpService = httpService
    }
    
    func retriveRedditTopPosts(keyword: String) -> Single<TopPosts> {
     
        var httpRequestDisposable: Disposable? = nil
        
        return Single.create { [weak self] observer -> Disposable in
            
            guard let strongSelf = self else {
                observer(.error(RedditServiceErrorBuilder.error(forCode: RedditServiceErrorCode.ReferenceError)))
                return Disposables.create()
            }
            
            let redditUrl = RedditServiceConfig.postUrlString
            let endpoint = redditUrl.replacingOccurrences(of: "{KEYWORD}", with: keyword)
                        
            httpRequestDisposable = strongSelf.httpService.makeGetHttpRequest(endpoint: endpoint)
                .subscribe(onSuccess: { (httpResponse) in
                    
                    let jsonData = httpResponse.data
                    
                    do {
                        
                        let top = try JSONDecoder().decode(TopPosts.self, from: jsonData)
                                             
                        observer(.success(top))
                     
                        httpRequestDisposable?.dispose()
                        
                    } catch {
                        
                        observer(.error(RedditServiceErrorBuilder.error(forCode: RedditServiceErrorCode.JsonFormatError)))
                    }
                    
                }, onError: { (error) in
                    
                    observer(.error(RedditServiceErrorBuilder.error(forCode: RedditServiceErrorCode.RequestFailed)))
                })
                    
            return Disposables.create()
        }
    }
}
