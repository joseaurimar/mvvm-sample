//
//  CatBreedViewController.swift
//  sword-health-test
//
//  Created by MAC on 11/02/2025.
//

import UIKit

class CatBreedViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            
            collectionView.register(cellClass: CatBreedCollectionViewCell.self)
        }
    }
    
    private let viewModel = CatBreedViewModel()
    private var pageSize = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
    }
    
    func initViewModel() {
        viewModel.reloadCollectionView = {
            DispatchQueue.main.async {
//                self.loaderIndicator.isHidden = true
                self.collectionView.reloadData()
            }
        }
        
//        loaderIndicator.startAnimating()
        viewModel.getCatBreeds(pageSize: pageSize)
    }
}

extension CatBreedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatBreedCollectionViewCell", for: indexPath) as? CatBreedCollectionViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        
        let viewModel = viewModel.getCellViewModel(at: indexPath)
        cell.nameLabel.text = viewModel.nameText
//        cell.ratingLabel.text = viewModel.ratingText
//        cell.iconImage.image = UIImage(systemName: self.viewModel.getImage(at: indexPath))
        
        return cell
    }
}

extension CatBreedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
