//
//  RedditCacheServiceProtocol.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/11/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import Foundation
import RxSwift

protocol RedditCacheServiceProtocol {
    
    /// This function retrieve from the local cache
    /// the latest reddit top posts based on the keyword passed
    ///
    /// - Parameter keyword: reddit keyword
    /// - Returns: Parsed JSON as a TopPosts entity
    func retrieveRedditTopPostsFromCache(keyword: String) -> Single<TopPosts>

    /// This function stores into the local chace
    /// the data passed with the associated keyword.
    ///
    /// - Parameter keyword: reddit keyword
    /// - Parameter data: data to be cached
    func storeRedditPostsInCache(keyword: String, data: Data) -> Completable
    
    /// This function invalidate the local cache
    /// for the  keyword passed
    ///
    /// - Parameter keyword: reddit keyword
    func invalidateLocalCache(keyword: String) -> Completable
}
