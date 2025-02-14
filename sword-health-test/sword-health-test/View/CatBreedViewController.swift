//
//  CatBreedViewController.swift
//  sword-health-test
//
//  Created by MAC on 11/02/2025.
//

import UIKit
import Kingfisher

class CatBreedViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
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
        
        viewModel.fetchFavourites()
        
//        loaderIndicator.startAnimating()
        viewModel.getCatBreeds(pageSize: pageSize)
    }
    
    @IBAction func favouritesButtonTapped(_ sender: UIButton) {
        let favourites = FavouritesViewController()
        navigationController?.pushViewController(favourites, animated: true)
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
        cell.imageView.kf.setImage(with: viewModel.imageURL)
        cell.favouriteButton.setImage(viewModel.isFavourite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"), for: .normal)
        
        cell.favouriteButtonActionBlock = { [weak self] cell in
            let actualIndexPath = collectionView.indexPath(for: cell)!
            self?.viewModel.saveFavouriteBreed(indexPath: actualIndexPath)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = CatBreedDetailViewController(viewModel: viewModel.getDetailsViewModel(at: indexPath))
        navigationController?.pushViewController(detail, animated: true)
    }
}

extension CatBreedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 110)
    }
}

extension CatBreedViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text else { return }
        
        viewModel.searchCatBreed(by: text)
    }
}
