//
//  ReusableCollectionCell.swift
//  veteranoPizzaIntegration
//
//  Created by User on 02.02.2022.
//

import Foundation
import UIKit

protocol ReusableCollectionCell where Self: UICollectionViewCell {
    static var reuseIdentifier: String {get}
    static func register(for collectionView: UICollectionView)
    static func registerNib(for collectionView: UICollectionView)
}

extension ReusableCollectionCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static func register(for collectionView: UICollectionView) {
        collectionView.register(self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    static func registerNib(for collectionView: UICollectionView) {
        collectionView.register(.init(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    static func deque(for collectionView: UICollectionView, indexPath: IndexPath) -> Self? {
        return collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? Self
    }
}
