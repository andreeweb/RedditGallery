//
//  GallerySettingsViewController.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/11/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import UIKit
import RxSwift

class GallerySettingsViewController: UITableViewController, GallerySettingsViewControllerProtocol {    

    @IBOutlet weak var imageCacheValue: UILabel!
    @IBOutlet weak var dataCacheValue: UILabel!
    @IBOutlet weak var deleteCacheButton: UIButton!
    
    private var disposeBag = DisposeBag()
    
    var viewModel: GallerySettingsViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bindDataCache(with: viewModel)
        bindImageCache(with: viewModel)
        bindDeleteCacheButtonItem(with: viewModel)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.eventViewAppeared()
    }

    private func bindImageCache(with viewModel: GallerySettingsViewModelProtocol) {
        
        viewModel.imageCache
            .subscribe(onNext: { [weak self] imageCache in
                
                DispatchQueue.main.async {
                    self?.imageCacheValue.text = String(format: "%.2f", imageCache)
                        + " "
                        + NSLocalizedString("kb", comment: "")
                }
                
            }).disposed(by: disposeBag)
    }
    
    private func bindDataCache(with viewModel: GallerySettingsViewModelProtocol) {
        
        viewModel.dataCache
            .subscribe(onNext: { [weak self] dataCache in
                
                DispatchQueue.main.async {
                    self?.dataCacheValue.text = String(format: "%.2f", dataCache)
                        + " "
                        + NSLocalizedString("kb", comment: "")
                }

            }).disposed(by: disposeBag)
    }
    
    private func bindDeleteCacheButtonItem(with viewModel: GallerySettingsViewModelProtocol) {
        
        deleteCacheButton.rx.tap
            .bind { [weak self] in
                
                self?.viewModel.deleteCacheRequested()
                
        }.disposed(by: disposeBag)
    }
}
