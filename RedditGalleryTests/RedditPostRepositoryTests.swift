//
//  RedditPostRepositoryTests.swift
//  RedditGalleryTests
//
//  Created by Andrea Cerra on 7/12/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxBlocking
import RxTest

@testable import RedditGallery

class RedditPostRepositoryTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPostRetrieve() throws {
        
        let httpService = HTTPService()
        let fileService = FileService()
        
        let redditService = RedditService(httpService: httpService)
        let redditCache = RedditCacheService(fileService: fileService)
        
        let postRepository = RedditPostRepository(redditService: redditService, cacheService: redditCache)
        
        let posts = try postRepository.getRedditPostPerKeyword(keyword: "spacex")
            .toBlocking()
            .last()
        
        XCTAssert((posts as Any) is TopPosts)
    }
    
    func testPostRetrieveFromCache() throws {
         
        let fileService = FileService()
        
        let redditService = RedditServiceMock()
        let redditCache = RedditCacheService(fileService: fileService)
        
        let postRepository = RedditPostRepository(redditService: redditService, cacheService: redditCache)
        
        XCTAssertThrowsError(try postRepository
            .getRedditPostPerKeyword(keyword: "spacex")
            .toBlocking()
            .last()!) { error in
                XCTAssertEqual((error as NSError).code, 001)
        }
    }
}
