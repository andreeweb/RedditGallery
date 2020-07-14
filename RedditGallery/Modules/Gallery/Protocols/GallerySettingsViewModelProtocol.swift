//
//  GallerySettingsViewModelProtocol.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/11/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import Foundation
import RxSwift

protocol GallerySettingsViewModelProtocol {
    
    var imageCache: Observable<Double> { get }
    var dataCache: Observable<Double> { get }
    
    /// Method used for notify the ViewAppear
    func eventViewAppeared()
    
    /// Method for delete all the local cache data
    func deleteCacheRequested()
}
