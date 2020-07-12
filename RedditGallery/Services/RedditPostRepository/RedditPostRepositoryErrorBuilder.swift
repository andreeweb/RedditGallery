//
//  RedditPostRepositoryErrorBuilder.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/11/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import Foundation

enum RedditPostRepositoryErrorCode: Int {
    
    case ReferenceError = 000
    case NoDataForThisKeyword = 001
}

final class RedditPostRepositoryErrorBuilder {
    
    // Domain identifier
    static var domain: String = "com.testapp.RedditGallery.RedditPostRepositoryErrorBuilder"
    
    // NSError helper function
    static func error(forCode code: RedditPostRepositoryErrorCode) -> NSError {
        
        var userInfo = [String: Any]()
        userInfo[NSLocalizedDescriptionKey] = localizedDescription(forCode: code)
        
        return NSError(domain: domain, code: code.rawValue, userInfo: userInfo)
    }
    
    // NSString, a complete sentence (or more) describing ideally both what failed and why it failed.
    static func localizedDescription(forCode code: RedditPostRepositoryErrorCode) -> String {
        switch code {
        case .ReferenceError:
            return """
            The object that is the source of this Observable was destroyed.
            It's programmer's error, please check documentation of error for more details
            """
        case .NoDataForThisKeyword:
            return " No posts available for the provided keyword "
        }
    }
}
