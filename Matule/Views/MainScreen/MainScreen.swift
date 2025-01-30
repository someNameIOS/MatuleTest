//
//  MainScreen.swift
//  Matule
//
//  Created by  MacBook Air on 07.01.2025.
//

import UIKit

// MARK: View
class MainScreen: UIViewController {
    
    let collectionData = MainSectionModel.mockData()
    
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
        
        // Отложенное выполнение установки цвета
        DispatchQueue.main.async {
            let firstIndexPath = IndexPath(item: 0, section: 1)
            self.collectionView.selectItem(at: firstIndexPath, animated: false, scrollPosition: .top)
            self.selectedIndexPath = firstIndexPath
            if let cell = self.collectionView.cellForItem(at: firstIndexPath) as? CategoryCell {
                cell.contentView.backgroundColor = .appAccent
                cell.label.textColor = .appBlock
            }
        }
        
        view.addSubview(collectionView)
    }
    
    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: createLayout
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
    
    // MARK: createSearchSection
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
    
    // MARK: createCategorySection
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
    
    // MARK: createPopularSection
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
    
    // MARK: createStockSection
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
    
    // MARK: setupHeaderSize
    private func setupHeaderSize(for section: Int) -> NSCollectionLayoutBoundarySupplementaryItem {
        let height: CGFloat = section == 0 ? 44 : 19
        return NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .absolute(height)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
    
}

// MARK: dataSource
extension MainScreen: UICollectionViewDataSource {
    
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
extension MainScreen: UICollectionViewDelegate {
    
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
                return header
            }
        }
        
        return UICollectionReusableView()
    }
    
    // фунукция для изменения ячейки при её нажатии
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section == 1 else { return }
        
        if let previousIndexPath = selectedIndexPath {
            if let previousCell = collectionView.cellForItem(at: previousIndexPath) as? CategoryCell {
                previousCell.contentView.backgroundColor = .appBlock
                previousCell.label.textColor = .appText
            }
        }
        
        if let newCell = collectionView.cellForItem(at: indexPath) as? CategoryCell {
            newCell.contentView.backgroundColor = .appAccent
            newCell.label.textColor = .appBlock
        }
        selectedIndexPath = indexPath
    }
    
}
