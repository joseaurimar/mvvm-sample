//
//  CatBreedCollectionViewCell.swift
//  sword-health-test
//
//  Created by MAC on 11/02/2025.
//

import UIKit

final class CatBreedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    var favouriteButtonActionBlock: ((UICollectionViewCell) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func favouriteButtonTapped(_ sender: UIButton) {
        favouriteButtonActionBlock?(self)
    }
}
