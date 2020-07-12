//
//  RedditCacheServiceTests.swift
//  RedditGalleryTests
//
//  Created by Andrea Cerra on 7/11/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxBlocking
import RxTest

@testable import RedditGallery

class RedditCacheServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCache(){
        
        let fileService = FileService()
        let redditCache = RedditCacheService(fileService: fileService)
            
        let jData = JData(modhash: "modhash-test", dist: 2, children: [])
        let topPosts = TopPosts(kind: "kind-test", data: jData)
        
        _ = try! redditCache.storeRedditPostsInCache(keyword: "test", topPosts: topPosts)
            .toBlocking()
            .last()
        
        let postsFromCache = try! redditCache.retrieveRedditTopPostsFromCache(keyword: "test")
            .toBlocking()
            .last()
        
        XCTAssertEqual(postsFromCache?.kind, "kind-test")
        XCTAssertEqual(postsFromCache?.data.modhash, "modhash-test")
        XCTAssertEqual(postsFromCache?.data.children.count, 0)
        
        _ = try! redditCache.invalidateLocalCache(keyword: "test")
            .toBlocking()
            .last()
        
        XCTAssertThrowsError(try redditCache
            .retrieveRedditTopPostsFromCache(keyword: "test")
            .toBlocking()
            .last()!) { error in
                XCTAssertEqual((error as NSError).code, 000)
        }
    }
    
    func testUpdateCache(){
        
        let fileService = FileService()
        let redditCache = RedditCacheService(fileService: fileService)
        
        let jData = JData(modhash: "modhash-test", dist: 2, children: [])
        let topPosts = TopPosts(kind: "kind-test", data: jData)
        
        _ = try! redditCache.storeRedditPostsInCache(keyword: "test", topPosts: topPosts)
            .toBlocking()
            .last()

        let jData2 = JData(modhash: "modhash-test2", dist: 5, children: [])
        let topPosts2 = TopPosts(kind: "kind-test2", data: jData2)
        
        _ = try! redditCache.storeRedditPostsInCache(keyword: "test", topPosts: topPosts2)
            .toBlocking()
            .last()
        
        let postsFromCache = try! redditCache.retrieveRedditTopPostsFromCache(keyword: "test")
            .toBlocking()
            .last()
        
        XCTAssertEqual(postsFromCache?.kind, "kind-test2")
        XCTAssertEqual(postsFromCache?.data.modhash, "modhash-test2")
        XCTAssertEqual(postsFromCache?.data.children.count, 0)
        
        _ = try! redditCache.invalidateLocalCache(keyword: "test")
            .toBlocking()
            .last()
        
        XCTAssertThrowsError(try redditCache
            .retrieveRedditTopPostsFromCache(keyword: "test")
            .toBlocking()
            .last()!) { error in
                XCTAssertEqual((error as NSError).code, 000)
        }
    }
}
