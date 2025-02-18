//
//  FavoritesViewController.swift
//  Matule
//
//  Created by  MacBook Air on 06.02.2025.
//

import UIKit

class FavoritesViewController: UIViewController {
    private var favorites: [CatalogItemModel] = [] // Храним избранные товары
    
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
    }(UICollectionView(frame: .zero, collectionViewLayout: layout))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Избранное"
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.appText // Установить любой цвет по желанию
        ]
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: .back, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .appText

        view.addSubview(collectionView)
        collectionView.frame = view.bounds

        // Загружаем избранные товары при запуске
        loadFavorites()

        // Подписываемся на обновления списка избранного
        NotificationCenter.default.addObserver(self, selector: #selector(loadFavorites), name: NSNotification.Name("FavoritesUpdated"), object: nil)
    }

    @objc private func loadFavorites() {
        favorites = FavoriteManager.shared.getFavoriteItems() // Загружаем избранные товары
        collectionView.reloadData()
    }
}

// MARK: - UICollectionView DataSource
extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCell.reuseID, for: indexPath) as! PopularCell
        let item = favorites[indexPath.item]
        
        cell.setup(with: item) // Передаем, что товар в избранном
        return cell
    }
}

// MARK: - Кнопки навигации
extension FavoritesViewController {
    @objc func backButtonTapped() {
        if let tabBarController = self.tabBarController {
            tabBarController.selectedIndex = 0 // Индекс экрана Home
        }
    }
}
