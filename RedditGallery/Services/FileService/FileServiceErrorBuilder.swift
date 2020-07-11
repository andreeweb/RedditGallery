//
//  FileServiceErrorBuilder.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/12/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import Foundation

enum FileServiceErrorCode: Int {
    
    case CreateDirectoryError = 000
    case PathIsNotADirectory = 001
    case DirectoryDoesNotExist = 003
}

final class FileServiceErrorBuilder {
    
    // Domain identifier
    static var domain: String = "com.testapp.RedditGallery.HTTPServiceErrorBuilder"
    
    // NSError helper function
    static func error(forCode code: FileServiceErrorCode) -> NSError {
        
        var userInfo = [String: Any]()
        userInfo[NSLocalizedDescriptionKey] = localizedDescription(forCode: code)
        
        return NSError(domain: domain, code: code.rawValue, userInfo: userInfo)
    }
    
    // NSString, a complete sentence (or more) describing ideally both what failed and why it failed.
    static func localizedDescription(forCode code: FileServiceErrorCode) -> String {
        switch code {
        case .CreateDirectoryError: return " Error while creating the directory "
        case .PathIsNotADirectory: return " The path provided is not a directory "
        case .DirectoryDoesNotExist: return " Directory at path does not exist "
        }
    }
}
