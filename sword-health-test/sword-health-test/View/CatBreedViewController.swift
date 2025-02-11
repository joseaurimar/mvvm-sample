//
//  CatBreedViewController.swift
//  sword-health-test
//
//  Created by MAC on 11/02/2025.
//

import UIKit

class CatBreedViewController: UIViewController {
    
    private let viewModel = CatBreedViewModel()
    private var pageSize = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
    }
    
    func initViewModel() {
        viewModel.getCatBreeds(pageSize: pageSize)
    }
}
