//
//  GalleryDetailViewModelProtocol.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/14/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import Foundation
import RxSwift

protocol GalleryDetailViewModelProtocol {
    
    var imageData: Observable<UIImage> { get }
    var titleData: Observable<String> { get }
}
