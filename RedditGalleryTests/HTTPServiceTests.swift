//
//  HTTPServiceTests.swift
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

class HTTPServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testHTTPGetRequestSuccess() throws {
        
        let httpService = HTTPService()
                
        let response = try httpService
            .makeGetHttpRequest(endpoint: "https://www.reddit.com/r/spacex/top.json")
            .toBlocking()
            .last()!
        
        XCTAssert((response.data as Any) is Data)
    }
    
    func testHTTPGetRequestWrongAddress() throws {
        
        let httpService = HTTPService()
        
        XCTAssertThrowsError(try httpService
            .makeGetHttpRequest(endpoint: "https://www.reddt.com/r/spacex/top.json")
            .toBlocking()
            .last()!) { error in
                XCTAssertEqual((error as NSError).code, 001)
        }
    }
}
