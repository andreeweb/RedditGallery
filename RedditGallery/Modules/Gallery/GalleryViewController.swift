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
    @IBOutlet weak var centerLabel: UILabel!
    private let searchController = UISearchController(searchResultsController: nil)
    private let spinner = UIActivityIndicatorView(style: .large)
    
    private var disposeBag = DisposeBag()
    private let reuseIdentifier = "PostCell"
    private var postsTableData: [Post] = []
    
    var viewModel: GalleryViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        // Do any additional setup after loading the view.
        bindTableDataSource(with: viewModel)
    }
    
    private func setupUI() {
        
        // navigation
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // search
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.placeholder = NSLocalizedString("search_placeholder", comment: "")
        searchController.searchBar.delegate = self
        
        // indicator
        spinner.color = .black
        spinner.hidesWhenStopped = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: spinner)
    }
    
    private func bindTableDataSource(with viewModel: GalleryViewModelProtocol) {
        
        viewModel.tableData
            .skip(1)
            .subscribe(onNext: { [weak self] tableData in
                
                if tableData.count == 0 {
                                        
                    DispatchQueue.main.async {
                        self?.centerLabel.isHidden = false
                        self?.centerLabel.text = NSLocalizedString("no_data", comment: "")
                    }
                    
                }else{
                    
                    DispatchQueue.main.async {
                        self?.centerLabel.isHidden = true
                    }
                }
                
                // new data
                self?.postsTableData = tableData
                
                // update on main thread
                DispatchQueue.main.async {
                    self?.spinner.stopAnimating()
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

extension GalleryViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
                
        spinner.startAnimating()
        
        // request data
        viewModel.searchPostByKeyword(keyword: searchBar.text ?? "")
        
        self.searchController.dismiss(animated: true, completion: nil)
    }
}
