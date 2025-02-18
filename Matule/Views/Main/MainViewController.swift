//
//  MainScreen.swift
//  Matule
//
//  Created by  MacBook Air on 07.01.2025.
//

import UIKit

// MARK: View
class MainViewController: UIViewController {
    
    var collectionData = MainSectionModel.mockData()
    private let manager = NetworkManager()
    
    // Индекс выбранной ячейки
    var selectedIndexPath: IndexPath?
    
    lazy var collectionView: UICollectionView = {
        $0.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.reuseID)
        $0.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseID)
        $0.register(PopularCell.self, forCellWithReuseIdentifier: PopularCell.reuseID)
        $0.register(StockCell.self, forCellWithReuseIdentifier: StockCell.reuseID)
        $0.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseID)
        $0.register(SearchSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchSectionHeader.reuseID)
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = .appBackground
        return $0
    }(UICollectionView(frame: view.frame, collectionViewLayout: createLayout()))
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        NotificationCenter.default.addObserver(self, selector: #selector(handleFavoritesUpdated), name: NSNotification.Name("FavoritesUpdated"), object: nil)
        manager.sendRequest(count: 2) { [weak self] items in
            guard let self = self else { return }
            collectionData[2].items = items
            collectionView.reloadData()
        }
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { section, _ in
            switch section {
            case 0: return self.createSearchSection()
            case 1: return self.createCategorySection()
            case 2: return self.createPopularSection()
            default: return self.createStockSection()
            }
        }
    }
    
    private func createSearchSection() -> NSCollectionLayoutSection {
        //Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .absolute(52))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(52))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        //Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 19, leading: 20, bottom: 24, trailing: 20)
        
        section.boundarySupplementaryItems = [self.setupHeaderSize(for: 0)]
        
        return section
    }
    
    private func createCategorySection() -> NSCollectionLayoutSection {
        //Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 16)
        
        //Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(124),
                                               heightDimension: .absolute(40))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        //Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 19, leading: 20, bottom: 24, trailing: 20)
        
        section.boundarySupplementaryItems = [self.setupHeaderSize(for: 1)]
        
        return section
    }
    
    private func createPopularSection() -> NSCollectionLayoutSection {
        //Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(view.frame.width / 2 - 28),
                                              heightDimension: .absolute(182))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(175),
                                               heightDimension: .absolute(194))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(16)
        
        //Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 20, bottom: 29, trailing: 20)
        
        section.boundarySupplementaryItems = [self.setupHeaderSize(for: 2)]
        
        return section
    }
    
    private func createStockSection() -> NSCollectionLayoutSection {
        //Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20)
        
        //Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(view.frame.width - 20),
                                               heightDimension: .absolute(95))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        //Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20)
        
        section.boundarySupplementaryItems = [self.setupHeaderSize(for: 3)]
        
        return section
    }
    
    private func setupHeaderSize(for section: Int) -> NSCollectionLayoutBoundarySupplementaryItem {
        let height: CGFloat = section == 0 ? 44 : 19
        return NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .absolute(height)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("FavoritesUpdated"), object: nil)
    }
}

// MARK: dataSource
extension MainViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionData[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionData[indexPath.section].items[indexPath.item]
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.reuseID, for: indexPath) as! SearchCell
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseID, for: indexPath) as! CategoryCell
            cell.setup(with: item)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCell.reuseID, for: indexPath) as! PopularCell
            cell.setup(with: item)
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StockCell.reuseID, for: indexPath) as! StockCell
            cell.setup(with: item)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
}

// MARK: delegate
extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = collectionData[indexPath.section]
        
        if kind == UICollectionView.elementKindSectionHeader {
            switch section.headerType {
            case .search:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchSectionHeader.reuseID, for: indexPath) as! SearchSectionHeader
                return header
            default:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseID, for: indexPath) as! SectionHeader
                header.setup(model: section, type: section.headerType)
                header.isPopular = indexPath.section == 2
                header.viewController = self
                return header
            }
        }
        
        return UICollectionReusableView()
    }
}

//MARK: Controller
extension MainViewController {
    @objc private func handleFavoritesUpdated() {
        collectionView.reloadData()
    }
}
