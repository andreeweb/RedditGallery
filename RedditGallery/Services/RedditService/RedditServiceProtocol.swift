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
        
    /// This function retrun the reddit top post based on the keyword passed
    ///
    /// - Parameter keyword: reddit keyword
    /// - Returns: TopPosts model
    func retriveRedditTopPosts(keyword: String) -> Single<TopPosts>
}
