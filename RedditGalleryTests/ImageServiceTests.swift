//
//  ImageServiceTests.swift
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

class ImageServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDownloadImage() throws {
        
        let httpService = HTTPService()
        let imageService = ImageService(httpService: httpService)
        
        let image = try imageService
            .getImage(imageUrl: "https://a.thumbs.redditmedia.com/x1svVj-hKxKxpcMtd21Lopp21S-_rhzjqUngqFjlo_0.jpg")
            .toBlocking()
            .last()!
        
        XCTAssert((image as Any) is UIImage)
    }
    
    func testDownloadWrongImage() throws {
        
        let httpService = HTTPService()
        let imageService = ImageService(httpService: httpService)
        
        XCTAssertThrowsError(try imageService
            .getImage(imageUrl: "https://a.thumbs.redditmedia.com/.jpg")
            .toBlocking()
            .last()!) { error in
                XCTAssertEqual((error as NSError).code, 002)
        }
    }
}
