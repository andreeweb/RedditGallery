//
//  GalleryDetailViewController.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/14/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import UIKit
import RxSwift

class GalleryDetailViewController: UIViewController, GalleryDetailViewControllerProtocol {
    
    @IBOutlet weak var imageView: UIImageView!
    
    private var disposeBag = DisposeBag()
    
    var viewModel: GalleryDetailViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        // Do any additional setup after loading the view.
        bindImageDataSource(with: viewModel)
        bindTitleDataSource(with: viewModel)
    }
    
    private func setupUI() {
        
    }
    
    private func bindImageDataSource(with viewModel: GalleryDetailViewModelProtocol) {
        
        viewModel.imageData
            .subscribe(onNext: { [weak self] imageData in
                
                self?.imageView.image = imageData
                
            }).disposed(by: disposeBag)
    }
    
    private func bindTitleDataSource(with viewModel: GalleryDetailViewModelProtocol) {
        
        viewModel.titleData
            .subscribe(onNext: { [weak self] title in
                
                self?.title = title
                
            }).disposed(by: disposeBag)
    }
}
