//
//  FileServiceProtocol.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/11/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import Foundation

protocol FileServiceProtocol {
    
    /// It retrieves the documents directory path and
    /// append to that path the subPath parameter.
    ///
    /// If the directory doesn't exist it will be created.
    ///
    /// - Parameter subPath: sub path to be added
    /// - Returns: Path URL
    func getDirectoryPath(subPath: String) throws -> URL
    
    /// Returns the directory size at the path provided  in bytes
    ///
    /// - Parameter path: directory path
    /// - Returns: Directory size
    func getDirectorySize(path: URL) throws -> Double

    /// Removes the directory at the path provided
    ///
    /// - Parameter path: directory path
    func deleteDirectory(path: URL) throws
}
