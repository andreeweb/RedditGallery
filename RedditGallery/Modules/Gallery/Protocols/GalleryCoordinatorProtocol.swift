//
//  GalleryCoordinatorProtocol.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/11/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import Foundation

protocol GalleryCoordinatorProtocol: CoordinatorProtocol {
    
    /// Method used for navigate to the detail page
    ///
    /// - Parameter post: post to show in the detail
    func navigateToDetailView(post: Post)
}
