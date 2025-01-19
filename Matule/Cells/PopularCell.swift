//
//  PopularCell.swift
//  Matule
//
//  Created by  MacBook Air on 12.01.2025.
//

import UIKit

// MARK: View
class PopularCell: UICollectionViewCell {
    
    static let reuseID: String = "PopularCell"
    var favoriteIconClicked: Bool = false
    var addIconClicked: Bool = false
    
    lazy var image: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    
    lazy var favoriteButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        $0.setImage(.favorite.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .appText
        return $0
    }(UIButton())
    
    lazy var descriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .appAccent
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    lazy var shoeNameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .appHint
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    lazy var priceLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .appText
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    lazy var customView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .appAccent
        return $0
    }(UIView())
    
    lazy var addToCartButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(addToCartButtonTapped), for: .touchUpInside)
        $0.setImage(.append.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .appBlock
        $0.imageView?.contentMode = .scaleAspectFill
        return $0
    }(UIButton())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .appBlock
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        
        contentView.addSubviews(image, favoriteButton, descriptionLabel, shoeNameLabel, priceLabel, customView)
        customView.addSubview(addToCartButton)
        
        
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        customView.layoutIfNeeded()
        customView.roundCorners([.topLeft], radius: 16)
    }
    
    func setup(with model: MainItemModel) {
        image.image = UIImage(named: model.shoeImage ?? "")
        descriptionLabel.text = model.description
        shoeNameLabel.text = model.shoeName
        priceLabel.text = model.price
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 9),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -9),
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            image.heightAnchor.constraint(equalToConstant: 70),
            
            favoriteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            favoriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            favoriteButton.widthAnchor.constraint(equalToConstant: 16),
            favoriteButton.heightAnchor.constraint(equalToConstant: 16),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 9),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -9),
            descriptionLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 12),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 16),
            
            shoeNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 9),
            shoeNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -9),
            shoeNameLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            shoeNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 9),
            priceLabel.topAnchor.constraint(equalTo: shoeNameLabel.bottomAnchor, constant: 14),
            priceLabel.widthAnchor.constraint(equalToConstant: 70),
            priceLabel.heightAnchor.constraint(equalToConstant: 16),
            
            customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            customView.widthAnchor.constraint(equalToConstant: 34),
            customView.heightAnchor.constraint(equalToConstant: 34),
            
            addToCartButton.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 8),
            addToCartButton.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -8),
            addToCartButton.topAnchor.constraint(equalTo: customView.topAnchor, constant: 8),
            addToCartButton.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: Controller
extension PopularCell {
        
    // Нажатии на кнопку избранное
    @objc func favoriteButtonTapped() {
        favoriteIconClicked.toggle()
                
        let imageName: String = favoriteIconClicked ? "FavoriteFill" : "Favorite"
        favoriteButton.setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
        favoriteButton.tintColor = favoriteIconClicked ? .appRed : .appText
    }
    
    // Нажатие на кнопку корзина
    @objc func addToCartButtonTapped() {
        addIconClicked.toggle()
        
        let imageName: String = addIconClicked ? "Cart" : "Append"
        addToCartButton.setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
}
