//
//  FavoritesViewControlelr.swift
//  Matule
//
//  Created by  MacBook Air on 03.02.2025.
//

import UIKit

class PopularViewController: UIViewController {
    private let manager = NetworkManager()
    var items: [CatalogItemModel] = []
    
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
        $0.backgroundColor = .appBackground
        $0.register(PopularCell.self, forCellWithReuseIdentifier: PopularCell.reuseID)
        $0.showsVerticalScrollIndicator = false
        $0.alwaysBounceVertical = true
        return $0
    }(UICollectionView(frame: view.frame, collectionViewLayout: layout))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Популярное"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: .back, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .appText
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .favorite, style: .plain, target: self, action: #selector(favouritesButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .appText
        
        view.addSubviews(collectionView)
        NotificationCenter.default.addObserver(self, selector: #selector(handleFavoritesUpdated), name: NSNotification.Name("FavoritesUpdated"), object: nil)
        manager.sendRequest(count: 14) { [weak self] items in
            guard let self = self else { return }
            self.items = items
            collectionView.reloadData()
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("FavoritesUpdated"), object: nil)
    }
}

extension PopularViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCell.reuseID, for: indexPath) as! PopularCell
        let item = items[indexPath.item]
        
        cell.setup(with: item)
        return cell
    }
}

extension PopularViewController {
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func favouritesButtonTapped() {
        
    }
    
    @objc private func handleFavoritesUpdated() {
        collectionView.reloadData()
    }
}

