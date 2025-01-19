//
//  CategoryCell.swift
//  Matule
//
//  Created by  MacBook Air on 11.01.2025.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    static var reuseID: String = "CategoryCell"
    
    lazy var label: UILabel = {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .appText
        $0.textAlignment = .center
        return $0
    }(UILabel(frame: CGRect(x: 10, y: 11, width: contentView.bounds.width - 20, height: 12)))
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .appBlock
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(label)
    }
    
    func setup(with model: MainItemModel) {
        label.text = model.categoryName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
