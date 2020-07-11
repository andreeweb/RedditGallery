//
//  RedditServiceTests.swift
//  RedditGalleryTests
//
//  Created by Andrea Cerra on 7/11/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import XCTest
import RxBlocking

@testable import RedditGallery

class RedditServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRedditJsonParsing() throws {
        
        let httpService = HTTPServiceMock()
        let redditService = RedditService(httpService: httpService)
        
        let posts = try redditService
            .retriveRedditTopPosts(keyword: "spacex")
            .toBlocking()
            .last()!
        
        XCTAssert((posts as Any) is TopPosts)
    }
    
    func testRedditWrongJson() throws {
        
        let httpService = HTTPServiceMock()
        httpService.trueJson = false
        
        let redditService = RedditService(httpService: httpService)
        
        XCTAssertThrowsError(try redditService
            .retriveRedditTopPosts(keyword: "spacex")
            .toBlocking()
            .last()!) { error in
                XCTAssertEqual((error as NSError).code, 001)
        }
    }
}
