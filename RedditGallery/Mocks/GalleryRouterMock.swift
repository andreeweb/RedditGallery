//
//  GalleryRouterMock.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/13/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import UIKit

class GalleryRouterMock: GalleryRouterProtocol {
    
    func navigateToDetailView(post: Post) {
        fatalError()
    }
    
    static func initRouter() -> UIViewController {
            
        return UIViewController()
    }
}
