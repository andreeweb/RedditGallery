//
//  ImageRepositoryProtocol.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/13/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import Foundation
import RxSwift

protocol ImageRepositoryProtocol {
    
    /// This function retrieve the image linked by the url from the web.
    /// If during the request something goes wrong, this function will
    /// return data from the local cache, if available.
    ///
    /// - Parameter keyword: filter keyword for the posts
    /// - Returns: Array of reddit posts.
    func getImage(imageURL: String) -> Single<UIImage>
}
