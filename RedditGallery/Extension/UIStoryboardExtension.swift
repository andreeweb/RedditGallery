//
//  UIStoryboardExtension.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/11/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    func instantiateNavigationController(withIdentifier identifier: String) -> UINavigationController {
        return instantiateViewController(withIdentifier: identifier) as! UINavigationController
    }
    
    func instantiateTabBarController(withIdentifier identifier: String) -> UITabBarController {
        return instantiateViewController(withIdentifier: identifier) as! UITabBarController
    }
}
