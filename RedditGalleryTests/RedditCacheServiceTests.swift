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
            
        let jsonData: Data? = """
            {
              "kind": "Listing",
              "data": {
                "modhash": "",
                "dist": 2,
                "children": [
                  {
                    "kind": "t3",
                    "data": {
                      "title": "What OneWeb's $1 billion rescue from bankruptcy means for SpaceX's Starlink",
                      "thumbnail": "https://a.thumbs.redditmedia.com/x1svVj-hKxKxpcMtd21Lopp21S-_rhzjqUngqFjlo_0.jpg",
                    }
                  },
                  {
                    "kind": "t3",
                    "data": {
                      "title": "Brilliant behind the scenes look at @SpaceX and @NASA Crew Dragon launch from @Space_Station point-of-view",
                      "thumbnail": "https://b.thumbs.redditmedia.com/HicreXfG0HE4kCNwh0Bvsknegza0BUb20FHK61422ks.jpg",
                    }
                  }
                ],
                "after": null,
                "before": null
              }
            }
            """.data(using: .utf8)
        
        _ = try! redditCache.storeRedditPostsInCache(keyword: "test", data: jsonData!)
            .toBlocking()
            .last()
        
        let postsFromCache = try! redditCache.retrieveRedditTopPostsFromCache(keyword: "test")
            .toBlocking()
            .last()
        
        XCTAssertEqual(postsFromCache?.kind, "Listing")
        XCTAssertEqual(postsFromCache?.data.children.count, 2)
        
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
