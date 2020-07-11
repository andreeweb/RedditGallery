//
//  FileService.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/11/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import Foundation

class FileService: FileServiceProtocol {
        
    func getDirectoryPath(subPath: String) throws -> URL {
        
        let fileManager = FileManager.default
        let myDocuments = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let diskCacheStorageBaseUrl = myDocuments.appendingPathComponent(subPath)
        
        if !fileManager.fileExists(atPath: diskCacheStorageBaseUrl.path) {
                
            do {
                
                try fileManager.createDirectory(atPath: diskCacheStorageBaseUrl.path, withIntermediateDirectories: true, attributes: nil)
                
            } catch {
                
                throw FileServiceErrorBuilder.error(forCode: FileServiceErrorCode.CreateDirectoryError)
            }
            
        }
        
        return diskCacheStorageBaseUrl
    }
    
    func getDirectorySize(path: URL) throws -> Double {
        
        let fileManager = FileManager.default
        var isDir : ObjCBool = false
        var totalSize: Double = 0.0
        
        if fileManager.fileExists(atPath: path.path, isDirectory:&isDir) {
            
            if isDir.boolValue {
                
                let filesArray:[String] = (fileManager.subpaths(atPath: path.absoluteString) ?? []) as [String]
                
                for fileName in filesArray{
                    
                    let filePath = "\(path)/\(fileName)"
                                        
                    let attr = try fileManager.attributesOfItem(atPath: filePath)
                    totalSize += attr[FileAttributeKey.size] as! Double
                }
            
            } else {

                throw FileServiceErrorBuilder.error(forCode: FileServiceErrorCode.PathIsNotADirectory)
            }
            
        } else {
            
            throw FileServiceErrorBuilder.error(forCode: FileServiceErrorCode.PathIsNotADirectory)
        }
        
        return totalSize
    }
}
