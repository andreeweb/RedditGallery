//
//  GallerySettingsViewModel.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/11/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class GallerySettingsViewModel: GallerySettingsViewModelProtocol{
    
    private unowned let router: GalleryRouterProtocol
    
    private let fileService: FileServiceProtocol
    private let disposeBag: DisposeBag
    private var imageCacheRelay: BehaviorRelay<Double>
    private var dataCacheRelay: BehaviorRelay<Double>
    
    var imageCache: Observable<Double> {
        return self.imageCacheRelay.asObservable()
    }
    
    var dataCache: Observable<Double> {
        return self.dataCacheRelay.asObservable()
    }
    
    required init(router: GalleryRouterProtocol,
                  fileService: FileServiceProtocol) {
        
        self.router = router
        self.fileService = fileService
        self.disposeBag = DisposeBag()
        self.imageCacheRelay = BehaviorRelay<Double>(value: 0.0)
        self.dataCacheRelay = BehaviorRelay<Double>(value: 0.0)
    }
    
    func eventViewAppeared() {
        
        updateCacheValues()
    }
    
    func deleteCacheRequested() {
        
        do {
            
            let pathData = try fileService.getDirectoryPath(subPath: RedditCacheConfig.cacheFolder)
            try fileService.deleteDirectory(path: pathData)
                        
            let pathImage = try fileService.getDirectoryPath(subPath: ImageCacheConfig.cacheFolder)
            try fileService.deleteDirectory(path: pathImage)
                        
            updateCacheValues()
            
        } catch  {

            // error
        }
    }
    
    private func updateCacheValues() {
    
        do {
            
            let pathData = try fileService.getDirectoryPath(subPath: RedditCacheConfig.cacheFolder)
            let sizeData = try fileService.getDirectorySize(path: pathData)
            
            self.dataCacheRelay.accept(sizeData * pow(10, -3))
            
            let pathImage = try fileService.getDirectoryPath(subPath: ImageCacheConfig.cacheFolder)
            let sizeImage = try fileService.getDirectorySize(path: pathImage)
            
            self.imageCacheRelay.accept(sizeImage * pow(10, -3))
            
        } catch  {
            
            self.imageCacheRelay.accept(0.0)
            self.dataCacheRelay.accept(0.0)
        }
        
    }
}
