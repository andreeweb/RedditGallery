//
//  ImageCacheServiceErrorBuilder.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/12/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import Foundation

enum ImageCacheServiceErrorCode: Int {
    
    case CacheMissError = 000
    case InvalidateCacheError = 001
    case StoreCacheError = 002
    case ReferenceError = 003
}

final class ImageCacheServiceErrorBuilder {
    
    // Domain identifier
    static var domain: String = "com.testapp.RedditGallery.ImageCacheServiceErrorBuilder"
    
    // NSError helper function
    static func error(forCode code: ImageCacheServiceErrorCode) -> NSError {
        
        var userInfo = [String: Any]()
        userInfo[NSLocalizedDescriptionKey] = localizedDescription(forCode: code)
        
        return NSError(domain: domain, code: code.rawValue, userInfo: userInfo)
    }
    
    // NSString, a complete sentence (or more) describing ideally both what failed and why it failed.
    static func localizedDescription(forCode code: ImageCacheServiceErrorCode) -> String {
        switch code {
        case .CacheMissError:
            return """
            Data not available in cache
            """
        case .InvalidateCacheError:
            return """
            Invalidate cache error
            """
        case .StoreCacheError:
            return """
            StoreCache Error
            """
        case .ReferenceError:
            return """
            The object that is the source of this Observable was destroyed.
            It's programmer's error, please check documentation of error for more details
            """
        }
    }
}
