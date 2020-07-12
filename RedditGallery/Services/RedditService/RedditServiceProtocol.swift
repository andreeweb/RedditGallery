//
//  RedditServiceProtocol.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/11/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import Foundation
import RxSwift

protocol RedditServiceProtocol {
        
    /// This function retrieve from the web
    /// the latest reddit top posts based on the keyword passed
    ///
    /// - Parameter keyword: reddit keyword
    /// - Returns: Parsed JSON as a TopPosts entity
    func retriveRedditTopPosts(keyword: String) -> Single<TopPosts>
}
