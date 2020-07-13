//
//  GalleryViewModel.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/11/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class GalleryViewModel: GalleryViewModelProtocol {
    
    private unowned let coordinator: GalleryCoordinatorProtocol
    
    private let redditPostRepository: RedditPostRepositoryProtocol
    private let imageRepository: ImageRepositoryProtocol
    private let disposeBag: DisposeBag
    private var tableDataRelay: BehaviorRelay<[Post]>
    
    var tableData: Observable<[Post]> {
        return tableDataRelay.asObservable()
    }
    
    required init(coordinator: GalleryCoordinatorProtocol,
                  redditPostRepository: RedditPostRepositoryProtocol,
                  imageRepository: ImageRepositoryProtocol) {
        
        self.coordinator = coordinator
        self.redditPostRepository = redditPostRepository
        self.imageRepository = imageRepository
        self.disposeBag = DisposeBag()
        self.tableDataRelay = BehaviorRelay<[Post]>(value: [])
    }
    
    func searchPostByKeyword(keyword: String) {
                
        var tempArray: [Post] = []
        
        redditPostRepository.getRedditPostPerKeyword(keyword: keyword)
            .subscribe(onSuccess: { [weak self] topPosts in
                        
                for post in topPosts.data.children {
                    
                    let post = Post(title: post.data.title,
                                    thumbnail: post.data.thumbnail)
                    
                    tempArray.append(post)
                }
                
                self?.tableDataRelay.accept(tempArray)
                
            }, onError: { [weak self] error in
            
                self?.tableDataRelay.accept([])
            
            }).disposed(by: disposeBag)
    }
    
    func getImageFromURL(imageURL: String, completion: @escaping (UIImage) -> Void) {
        
        imageRepository.getImage(imageURL: imageURL)
            .subscribe(onSuccess: { (image) in
            
                completion(image)
                
        }) { (error) in
            
            completion(UIImage(imageLiteralResourceName: "no-image"))
            
        }.disposed(by: disposeBag)
    }
}
