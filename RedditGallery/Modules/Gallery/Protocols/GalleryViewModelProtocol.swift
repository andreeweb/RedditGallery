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
    
    func searchPostByKeyword(keyword: String)
    func getImageFromURL(imageURL: String, completion: @escaping (UIImage) -> Void)
}
