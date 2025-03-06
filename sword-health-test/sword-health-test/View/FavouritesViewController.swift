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
        
        title = "Favourities"
        
        initViewModel()
    }
    
    func initViewModel() {
        viewModel.reloadCollectionView = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        viewModel.deleteItemCollectionView = { indexPath in
            DispatchQueue.main.async {
                self.collectionView.deleteItems(at: [indexPath])
            }
        }
        
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
        cell.favouriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        
        cell.favouriteButtonActionBlock = { [weak self] cell in
            let actualIndexPath = collectionView.indexPath(for: cell)!
            self?.viewModel.deleteFavouriteFromDataBase(indexPath: actualIndexPath)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = CatBreedDetailViewController(viewModel: viewModel.getDetailsViewModel(at: indexPath))
        navigationController?.pushViewController(detail, animated: true)
    }
}

extension FavouritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 110)
    }
}
