//
//  ImageServiceProtocol.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/12/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import Foundation
import RxSwift

protocol ImageServiceProtocol {
    
    /// Download and returns UIImage from the URL passed.
    ///
    /// - Parameter imageUrl: image url
    /// - Returns: Parsed JSON as a TopPosts entity
    func getImage(imageUrl: String) -> Single<UIImage>
}
