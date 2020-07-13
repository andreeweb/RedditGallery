//
//  GalleryViewController.swift
//  RedditGallery
//
//  Created by Andrea Cerra on 7/11/20.
//  Copyright © 2020 Andrea Cerra. All rights reserved.
//

import UIKit
import RxSwift

final class GalleryViewController: UIViewController, GalleryViewControllerProtocol {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: GalleryViewModelProtocol!
    
    private var disposeBag = DisposeBag()
    private let reuseIdentifier = "PostCell"
    private var postsTableData: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bindTableDataSource(with: viewModel)
        
        // TODO add search bar and move inside the search action
        viewModel.searchPostByKeyword(keyword: "intel")
    }
    
    private func bindTableDataSource(with viewModel: GalleryViewModelProtocol) {
        
        viewModel.tableData
            .subscribe(onNext: { [weak self] tableData in
                      
                // new data
                self?.postsTableData = tableData
                
                // update on main thread
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
                
            }).disposed(by: disposeBag)
    }
}

extension GalleryViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postsTableData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PostCollectionViewCell
        
        let post = postsTableData[indexPath.row]
        
        viewModel.getImageFromURL(imageURL: post.thumbnail){ image in
            
            // update on main thread
            DispatchQueue.main.async {
                cell.postImage.image = image
                cell.loadingSpinner.stopAnimating()
            }
        }
        
        return cell
    }
}
