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
    
    func eventViewAppeared()
    func deleteCacheRequested()
}
