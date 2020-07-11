//
//  FileServiceTests.swift
//  RedditGalleryTests
//
//  Created by Andrea Cerra on 7/12/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import XCTest

@testable import RedditGallery

class FileServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFileServiceFileSize() throws {
        
        let fileService = FileService()
        
        let path = try fileService.getDirectoryPath(subPath: "directory")
        let size = try fileService.getDirectorySize(path: path)
        
        XCTAssertEqual(size, 0.0)
    }
}
