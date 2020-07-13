//
//  GalleryViewModelTest.swift
//  RedditGalleryTests
//
//  Created by Andrea Cerra on 7/13/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxBlocking
import RxTest

@testable import RedditGallery

class GalleryViewModelTest: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSearchPerKeyword() throws {
        
        // dependecies
        let httpService = HTTPService()
        let redditService = RedditService(httpService: httpService)
        let fileService = FileService()
        let redditCacheService = RedditCacheService(fileService: fileService)
        let redditPostRepository = RedditPostRepository(redditService: redditService,
                                                        cacheService: redditCacheService)
        
        let imageService = ImageService(httpService: httpService)
        let imageCacheService = ImageCacheService(fileService: fileService)
        let imageRepository = ImageRepository(imageService: imageService,
                                              cacheService: imageCacheService)
        
        // view model
        let galleryViewModel = GalleryViewModel(coordinator: GalleryCoordinatorMock(),
                                                redditPostRepository: redditPostRepository,
                                                imageRepository: imageRepository)
        
        galleryViewModel.searchPostByKeyword(keyword: "spacex")
        
        let result = try galleryViewModel
            .tableData
            .toBlocking()
            .first()
        
        XCTAssert((result as Any) is [Post])
    }
}
