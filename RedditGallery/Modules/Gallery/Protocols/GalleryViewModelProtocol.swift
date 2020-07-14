//
//  GalleryViewModelProtocol.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/11/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import Foundation
import RxSwift

protocol GalleryViewModelProtocol {
 
    var tableData: Observable<[Post]> { get }
    
    /// Method used for retrieve post by keword
    ///
    /// - Parameter post: post keyword
    func searchPostByKeyword(keyword: String)
    
    /// Method used for get image from the url passed
    ///
    /// - Parameter post: post to show in the detail
    /// - Returns: completion image
    func getImageFromURL(imageURL: String, completion: @escaping (UIImage) -> Void)
    
    /// Method to call when the user tap on a cell/row
    ///
    /// - Parameter indexPath: the indexpath retrieved from the delegate method
    func cellSelected(indexPath: IndexPath)
}
