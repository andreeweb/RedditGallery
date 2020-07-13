//
//  ImageRepository.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/13/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import Foundation
import RxSwift

class ImageRepository: ImageRepositoryProtocol {
    
    private let imageService: ImageServiceProtocol
    private let cacheService: ImageCacheServiceProtocol
    
    init(imageService: ImageServiceProtocol, cacheService: ImageCacheServiceProtocol) {
        self.imageService = imageService
        self.cacheService = cacheService
    }
    
    func getImage(imageURL: String) -> Single<UIImage> {
        
        var requestDisposable: Disposable? = nil
        var nestedRequestDisposable: Disposable? = nil
        
        return Single.create { [weak self] observer -> Disposable in
            
            guard let strongSelf = self else {
                observer(.error(ImageRepositoryErrorBuilder.error(forCode: ImageRepositoryErrorCode.ReferenceError)))
                return Disposables.create()
            }
            
            requestDisposable = strongSelf.cacheService.retrieveImageFromCache(imageURL: imageURL)
                .subscribe(onSuccess: { (image) in
                    
                    observer(.success(image))
                    requestDisposable?.dispose()
                    
                }, onError: { (error) in
                                        
                    nestedRequestDisposable = strongSelf.imageService.getImage(imageUrl: imageURL)
                        .subscribe(onSuccess: { (image) in
                                                        
                            // save data in cache
                            nestedRequestDisposable = strongSelf.cacheService.storeImageInCache(imageURL: imageURL, image: image)
                                .subscribe(onCompleted: {
                                    nestedRequestDisposable?.dispose()
                                    
                                }, onError: { (error) in
                                    
                                    print("Repository getImage :: \(error)")
                                })
                            
                            observer(.success(image))
                            nestedRequestDisposable?.dispose()
                            
                        }, onError: { (error) in
                            
                            observer(.error(ImageRepositoryErrorBuilder.error(forCode: ImageRepositoryErrorCode.NoImageForThisUrl)))
                        })
                })
            
            return Disposables.create()
        }
    }
}
