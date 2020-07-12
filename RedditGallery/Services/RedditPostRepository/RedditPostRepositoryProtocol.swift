//
//  RedditPostRepositoryProtocol.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/11/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import Foundation
import RxSwift

enum CacheOption {
    case OnlineFirst
    case LocalFirst
}

protocol RedditPostRepositoryProtocol {
    
    /// This function retrieve the latest reddit posts from the web.
    /// If during the request something goes wrong, this function will
    /// return data from the local cache, if available.
    ///
    /// - Parameter keyword: filter keyword for the posts
    /// - Returns: Array of reddit posts.
    func getRedditPostPerKeyword(keyword: String) -> Single<TopPosts>
}
