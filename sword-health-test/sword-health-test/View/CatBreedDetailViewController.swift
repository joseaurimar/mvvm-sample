//
//  CatBreedDetailViewController.swift
//  sword-health-test
//
//  Created by MAC on 12/02/2025.
//

import UIKit

final class CatBreedDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var temperamentLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private let viewModel: CatBreedDetailViewModel?
    
    init(viewModel: CatBreedDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "CatBreedDetailViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        nameLabel.text = viewModel?.nameText
        imageView.kf.setImage(with: viewModel?.imageURL)
        originLabel.text = viewModel?.originText
        temperamentLabel.text = viewModel?.temperamentText
        descriptionLabel.text = viewModel?.descriptionText
    }
}
