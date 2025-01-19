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
    
    // индекс выбранной ячейки
    var selectedIndexPath: IndexPath?
    
    lazy var collectionView: UICollectionView = {
        $0.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseID)
        $0.register(PopularCell.self, forCellWithReuseIdentifier: PopularCell.reuseID)
        $0.register(StockCell.self, forCellWithReuseIdentifier: StockCell.reuseID)
        $0.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseID)
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = .appBackground
        return $0
    }(UICollectionView(frame: view.frame, collectionViewLayout: createLayout()))
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        let nameImage = UIImage(named: "MainController")
        let image = UIImageView(image: nameImage)
        navigationItem.titleView = image
        
        // Отложенное выполнение установки цвета
        DispatchQueue.main.async {
            let firstIndexPath = IndexPath(item: 0, section: 0)
            self.collectionView.selectItem(at: firstIndexPath, animated: false, scrollPosition: .top)
            self.selectedIndexPath = firstIndexPath
            if let cell = self.collectionView.cellForItem(at: firstIndexPath) as? CategoryCell {
                cell.contentView.backgroundColor = .appAccent
                cell.label.textColor = .appBlock
            }
        }
        
        view.addSubview(collectionView)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { section, _ in
            switch section {
            case 0: self.createCategorySection()
            case 1: self.createPopularSection()
            default: self.createStockSection()
            }
        }
    }
    
    private func createCategorySection() -> NSCollectionLayoutSection {
        //Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(116), heightDimension: .absolute(40))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: 8, bottom: 0, trailing: 8)
        
        //Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 19, leading: 12, bottom: 24, trailing: 12)
        
        section.boundarySupplementaryItems = [self.setupHeaderSize()]
        
        return section
    }
    
    private func createPopularSection() -> NSCollectionLayoutSection {
        //Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(view.frame.width / 2 - 28), heightDimension: .absolute(182))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(175), heightDimension: .absolute(194))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(16)
        
        //Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 20, bottom: 29, trailing: 20)
        
        section.boundarySupplementaryItems = [self.setupHeaderSize()]
        
        return section
    }
    
    private func createStockSection() -> NSCollectionLayoutSection {
        //Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(view.frame.width - 40), heightDimension: .absolute(95))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        //Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20)
        
        section.boundarySupplementaryItems = [self.setupHeaderSize()]
        
        return section
    }
    
    private func setupHeaderSize() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                 heightDimension: .absolute(19)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
}

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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseID, for: indexPath) as! CategoryCell
            cell.setup(with: item)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCell.reuseID, for: indexPath) as! PopularCell
            cell.setup(with: item)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StockCell.reuseID, for: indexPath) as! StockCell
            cell.setup(with: item)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
}

extension MainScreen: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let item = collectionData[indexPath.section]
        
        if kind == UICollectionView.elementKindSectionHeader {
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseID, for: indexPath) as! SectionHeader
            
            switch indexPath.section {
            case 0:
                header.setup(model: item, type: .category)
            case 1:
                header.setup(model: item, type: .popular)
            default:
                header.setup(model: item, type: .stock )
            }
            
            return header
        }
        
        return UICollectionReusableView()
    }
    
    // фунукция для изменения ячейки при её нажатии
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section == 0 else { return }
        
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

// MARK: Controller
extension MainScreen {
    
}
