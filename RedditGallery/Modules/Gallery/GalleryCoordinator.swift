//
//  GalleryCoordinator.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/11/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import UIKit

class GalleryCoordinator: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initGalleryView()
    }
}

extension GalleryCoordinator: GalleryCoordinatorProtocol  {
    
    static func initCoordinator() -> UIViewController {
        
        let controller = UIStoryboard(name: "Gallery", bundle: nil)
            .instantiateTabBarController(withIdentifier: "GalleryTabBarController") as! GalleryCoordinator
        
        return controller
    }
    
    private func initGalleryView() {
        
        // dependecies
        let httpService = HTTPService()
        let redditService = RedditService(httpService: httpService)
        let fileService = FileService()
        let redditCacheService = RedditCacheService(fileService: fileService)
        let redditPostRepository = RedditPostRepository(redditService: redditService, cacheService: redditCacheService)
        
        // view model
        let galleryViewModel = GalleryViewModel(coordinator: self, redditPostRepository: redditPostRepository)
        
        // view model injection
        let galleryNavController = self.viewControllers![0] as! UINavigationController
        let galleryViewController = galleryNavController.viewControllers[0] as! GalleryViewController
        galleryViewController.viewModel = galleryViewModel
    }
}
