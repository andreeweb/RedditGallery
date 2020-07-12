//
//  ImageServiceErrorBuilder.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/12/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import Foundation

enum ImageServiceErrorCode: Int {
    
    case ImageDataError = 000
    case ReferenceError = 001
    case RequestError = 002
}

final class ImageServiceErrorBuilder {
    
    // Domain identifier
    static var domain: String = "com.testapp.RedditGallery.ImageServiceErrorBuilder"
    
    // NSError helper function
    static func error(forCode code: ImageServiceErrorCode) -> NSError {
        
        var userInfo = [String: Any]()
        userInfo[NSLocalizedDescriptionKey] = localizedDescription(forCode: code)
        
        return NSError(domain: domain, code: code.rawValue, userInfo: userInfo)
    }
    
    // NSString, a complete sentence (or more) describing ideally both what failed and why it failed.
    static func localizedDescription(forCode code: ImageServiceErrorCode) -> String {
        switch code {
        case .ReferenceError:
            return """
            The object that is the source of this Observable was destroyed.
            It's programmer's error, please check documentation of error for more details
            """
        case .ImageDataError:
            return """
            Error while trying to parse the image data.
            """
        case .RequestError:
            return """
            Error while trying to download the image data from the URL.
            """
        }
    }
}
