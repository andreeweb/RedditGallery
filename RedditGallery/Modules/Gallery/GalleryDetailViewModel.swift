//
//  GalleryDetailViewModel.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/14/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class GalleryDetailViewModel: GalleryDetailViewModelProtocol{
    
    private unowned let coordinator: GalleryCoordinatorProtocol
    
    private let imageRepository: ImageRepositoryProtocol
    private let post: Post
    private let disposeBag: DisposeBag
    private var imageDataRelay: BehaviorRelay<UIImage>
    private var titleDataRelay: BehaviorRelay<String>
    
    var imageData: Observable<UIImage> {
        return imageDataRelay.asObservable()
    }
    
    var titleData: Observable<String> {
        return titleDataRelay.asObservable()
    }
    
    required init(coordinator: GalleryCoordinatorProtocol,
                  imageRepository: ImageRepositoryProtocol,
                  post: Post) {
        
        self.coordinator = coordinator
        self.imageRepository = imageRepository
        self.post = post
        self.disposeBag = DisposeBag()
        
        self.imageDataRelay = BehaviorRelay<UIImage>(value:
            UIImage(imageLiteralResourceName: "no-image"))
        
        self.titleDataRelay = BehaviorRelay<String>(value: post.title)
        
        // get the image
        retrieveImagePost(post: post)
    }
    
    private func retrieveImagePost(post: Post) {
        
        imageRepository.getImage(imageURL: post.thumbnail)
            .subscribe(onSuccess: { [weak self] (image) in
            
                self?.imageDataRelay.accept(image)
                
            }) { [weak self] (error) in
            
                self?.imageDataRelay
                    .accept(UIImage(imageLiteralResourceName: "no-image"))
        
        }.disposed(by: disposeBag)
    }
}

