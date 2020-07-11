//
//  HTTPServiceErrorBuilder.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/11/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import Foundation

enum HTTPServiceErrorCode: Int {
    
    case ReferenceError = 000
    case HTTPRequestError = 001
    case HTTPResponseError = 002
    case HTTPInvalidJsonFormat = 003
}

final class HTTPServiceErrorBuilder {
    
    // Domain identifier
    static var domain: String = "com.testapp.RedditGallery.HTTPServiceErrorBuilder"
    
    // NSError helper function
    static func error(forCode code: HTTPServiceErrorCode) -> NSError {
        
        var userInfo = [String: Any]()
        userInfo[NSLocalizedDescriptionKey] = localizedDescription(forCode: code)
        
        return NSError(domain: domain, code: code.rawValue, userInfo: userInfo)
    }
    
    // NSString, a complete sentence (or more) describing ideally both what failed and why it failed.
    static func localizedDescription(forCode code: HTTPServiceErrorCode) -> String {
        switch code {
            case .ReferenceError:
                return """
                The object that is the source of this Observable was destroyed.
                It's programmer's error, please check documentation of error for more details
                """
            case .HTTPRequestError: return " HTTPRequestError "
            case .HTTPResponseError: return " HTTPResponseError "
            case .HTTPInvalidJsonFormat: return "Invalid Json Format"
        }
    }
}
