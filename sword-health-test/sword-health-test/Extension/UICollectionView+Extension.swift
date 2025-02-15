//
//  UICollectionView+Extension.swift
//  sword-health-test
//
//  Created by MAC on 11/02/2025.
//

import UIKit

extension UICollectionView {
    public func register<T: UICollectionViewCell>(cellClass: T.Type) {
        let cellIdentifier = String(describing: cellClass.self)
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
}
