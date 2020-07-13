//
//  ImageRepositoryErrorBuilder.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/13/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import Foundation

enum ImageRepositoryErrorCode: Int {
    
    case ReferenceError = 000
    case NoImageForThisUrl = 001
}

final class ImageRepositoryErrorBuilder {
    
    // Domain identifier
    static var domain: String = "com.testapp.RedditGallery.ImageRepositoryErrorBuilder"
    
    // NSError helper function
    static func error(forCode code: ImageRepositoryErrorCode) -> NSError {
        
        var userInfo = [String: Any]()
        userInfo[NSLocalizedDescriptionKey] = localizedDescription(forCode: code)
        
        return NSError(domain: domain, code: code.rawValue, userInfo: userInfo)
    }
    
    // NSString, a complete sentence (or more) describing ideally both what failed and why it failed.
    static func localizedDescription(forCode code: ImageRepositoryErrorCode) -> String {
        switch code {
        case .ReferenceError:
            return """
            The object that is the source of this Observable was destroyed.
            It's programmer's error, please check documentation of error for more details
            """
        case .NoImageForThisUrl:
            return " Image not available at the URL provided "
        }
    }
}
