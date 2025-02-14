//
//  FavouritesViewController.swift
//  sword-health-test
//
//  Created by MAC on 13/02/2025.
//

import UIKit

final class FavouritesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            
            collectionView.register(cellClass: CatBreedCollectionViewCell.self)
        }
    }
    
    private let viewModel = FavouriteViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getFavouritesFromDataBase()
    }
}

extension FavouritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatBreedCollectionViewCell", for: indexPath) as? CatBreedCollectionViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        
        let viewModel = viewModel.getCellViewModel(at: indexPath)
        cell.nameLabel.text = viewModel.nameText
        cell.imageView.kf.setImage(with: viewModel.imageURL)
        
        return cell
    }
}

extension FavouritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 110)
    }
}
