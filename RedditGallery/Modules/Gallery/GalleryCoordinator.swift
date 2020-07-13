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
        initSettingsView()
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
        let redditPostRepository = RedditPostRepository(redditService: redditService,
                                                        cacheService: redditCacheService)
        
        let imageService = ImageService(httpService: httpService)
        let imageCacheService = ImageCacheService(fileService: fileService)
        let imageRepository = ImageRepository(imageService: imageService,
                                              cacheService: imageCacheService)
        
        // view model
        let galleryViewModel = GalleryViewModel(coordinator: self,
                                                redditPostRepository: redditPostRepository,
                                                imageRepository: imageRepository)
        
        // view model injection
        let galleryNavController = self.viewControllers![0] as! UINavigationController
        let galleryViewController = galleryNavController.viewControllers[0] as! GalleryViewController
        galleryViewController.viewModel = galleryViewModel
    }
    
    private func initSettingsView() {
        
        // dependecies
        let fileService = FileService()
        
        // view model
        let settingsViewModel = GallerySettingsViewModel(coordinator: self,
                                                         fileService: fileService)
                
        // view model injection
        let settingsNavController = self.viewControllers![1] as! UINavigationController
        let settingsViewController = settingsNavController.viewControllers[0] as! GallerySettingsViewController
        settingsViewController.viewModel = settingsViewModel
    }
}
