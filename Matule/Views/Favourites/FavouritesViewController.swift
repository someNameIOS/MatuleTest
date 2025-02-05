//
//  FavoritesViewControlelr.swift
//  Matule
//
//  Created by  MacBook Air on 03.02.2025.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    lazy var layout: UICollectionViewFlowLayout = {
        $0.scrollDirection = .vertical
        $0.itemSize = CGSize(width: (view.frame.width - 55) / 2, height: 182)
        $0.minimumLineSpacing = 15
        return $0
    }(UICollectionViewFlowLayout())
    
    lazy var collectionView: UICollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        $0.dataSource = self
        $0.register(PopularCell.self, forCellWithReuseIdentifier: PopularCell.reuseID)
        $0.showsVerticalScrollIndicator = false
        $0.alwaysBounceVertical = true
        return $0
    }(UICollectionView(frame: view.frame, collectionViewLayout: layout))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appBackground
        
        view.addSubviews(collectionView)
        
    }
    
    
    
}

extension FavouritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCell.reuseID, for: indexPath) as! PopularCell
        return cell
    }
}
