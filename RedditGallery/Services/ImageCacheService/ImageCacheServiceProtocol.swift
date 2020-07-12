//
//  ImageCacheServiceProtocol.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/12/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import Foundation
import RxSwift

protocol ImageCacheServiceProtocol {
    
    /// Retrieve from the cache the image requested
    /// The URL should be the same of the web request
    ///
    /// - Parameter imageURl: image url
    /// - Returns: image
    func retrieveImageFromCache(imageURL: String) -> Single<UIImage>
    
    /// This function stores into the local chace
    /// the data image passed. The image is stored by using the url passed
    /// as a key.
    ///
    /// - Parameter imageURL: image url used as a key for store and retrieve
    /// - Parameter image: image to be cached
    func storeImageInCache(imageURL: String, image: UIImage) -> Completable
    
    /// This function remove from the local cache
    /// the referenced image by the url passed
    ///
    /// - Parameter keyword: reddit keyword
    func invalidateImageInCache(imageURL: String) -> Completable
}
