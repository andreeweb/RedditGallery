//
//  ImageCacheServiceTests.swift
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

class ImageCacheServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
    
        let imageURL = "https://a.thumbs.redditmedia.com/x1svVj-hKxKxpcMtd21Lopp21S-_rhzjqUngqFjlo_0.jpg"
        
        let httpService = HTTPService()
        let imageService = ImageService(httpService: httpService)
        
        let fileService = FileService()
        let imageCacheService = ImageCacheService(fileService: fileService)
        
        let image = try imageService
            .getImage(imageUrl: imageURL)
            .toBlocking()
            .last()!
        
        _ = try imageCacheService
            .storeImageInCache(imageURL: imageURL, image: image)
            .toBlocking()
            .last()
        
        let imageFromCache = try imageCacheService
            .retrieveImageFromCache(imageURL: imageURL)
            .toBlocking()
            .last()
        
        let imageData = image.pngData()
        let cacheImageData = imageFromCache?.pngData()
        
        XCTAssertEqual(imageData!, cacheImageData!)
        
        _ = try imageCacheService.invalidateImageInCache(imageURL: imageURL)
            .toBlocking()
            .last()
        
        XCTAssertThrowsError(try imageCacheService
            .retrieveImageFromCache(imageURL: imageURL)
            .toBlocking()
            .last()!) { error in
                XCTAssertEqual((error as NSError).code, 000)
        }
    }
}
