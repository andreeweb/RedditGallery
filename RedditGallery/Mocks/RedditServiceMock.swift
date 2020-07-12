//
//  RedditServiceMock.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/12/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import Foundation
import RxSwift

class RedditServiceMock: RedditServiceProtocol {
    
    func retriveRedditTopPosts(keyword: String) -> Single<TopPosts> {
        
        return Single.error(RedditServiceErrorBuilder.error(forCode: RedditServiceErrorCode.RequestFailed))
    }
}
