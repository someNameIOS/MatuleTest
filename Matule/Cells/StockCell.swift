//
//  StocksCell.swift
//  Matule
//
//  Created by  MacBook Air on 13.01.2025.
//

import UIKit

class StockCell: UICollectionViewCell {
    
    static var reuseID: String = "StocksCell"
    
    lazy var image: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(image)
        
        setupConstraints()
    }
    
    func setup(with model: MainItemModel) {
        image.image = UIImage(named: model.stocksImage ?? "")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor),
            image.topAnchor.constraint(equalTo: topAnchor),
            image.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
