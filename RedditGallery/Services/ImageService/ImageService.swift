//
//  ImageService.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/12/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import Foundation
import RxSwift

class ImageService: ImageServiceProtocol {
    
    private var httpService: HTTPServiceProtocol
    
    init(httpService: HTTPServiceProtocol) {
        self.httpService = httpService
    }
    
    func getImage(imageUrl: String) -> Single<UIImage> {
        
        var httpRequestDisposable: Disposable? = nil
        
        return Single.create { [weak self] observer -> Disposable in
            
            guard let strongSelf = self else {
                observer(.error(ImageServiceErrorBuilder.error(forCode: ImageServiceErrorCode.ReferenceError)))
                return Disposables.create()
            }
            
            httpRequestDisposable = strongSelf.httpService.makeGetHttpRequest(endpoint: imageUrl)
                .subscribe(onSuccess: { (httpResponse) in
                    
                    let imageData = httpResponse.data
                                        
                    guard let image = UIImage(data: imageData) else {
                        observer(.error(ImageServiceErrorBuilder.error(forCode: ImageServiceErrorCode.ImageDataError)))
                        return
                    }
                    
                    observer(.success(image))
                    
                    httpRequestDisposable?.dispose()
                    
                }, onError: { (error) in
                    
                    observer(.error(ImageServiceErrorBuilder.error(forCode: ImageServiceErrorCode.RequestError)))
                })
            
            return Disposables.create()
        }
    }
}
