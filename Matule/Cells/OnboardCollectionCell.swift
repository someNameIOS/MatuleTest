//
//  OnboardCollectionCell.swift
//  Matule
//
//  Created by  MacBook Air on 15.12.2024.
//

import UIKit

class OnboardCollectionCell: UICollectionViewCell {
    
    static var reuseID: String = "OnboardCollectionCell"
    
    lazy var titleLabel: Label = Label(labelColor: .appBlock, labelFont: .systemFont(ofSize: 30, weight: .heavy), labelAlignment: .center)
    
    lazy var imageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    
    lazy var descriptionLabel: Label = Label(labelColor: .appSubTextLight, labelFont: .systemFont(ofSize: 16, weight: .regular), labelAlignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = contentView.bounds
        gradientLayer.colors = [UIColor.appAccent.cgColor, UIColor.appSecondGradient.cgColor, UIColor.appThirdGradient.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        contentView.layer.addSublayer(gradientLayer)
        
        contentView.addSubviews(titleLabel, descriptionLabel, imageView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 302),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            
        ])
    }
    
    func configure(with model: OnboardModel, isFirst: Bool) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        imageView.image = UIImage(named: model.imageName)
        
        titleLabel.font = .systemFont(ofSize: isFirst ? 30 : 34, weight: isFirst ? .heavy : .semibold)
        imageView.topAnchor.constraint(equalTo: isFirst ? titleLabel.bottomAnchor : contentView.safeAreaLayoutGuide.topAnchor, constant: isFirst ? 130 : 37).isActive = true
        titleLabel.topAnchor.constraint(equalTo: isFirst ? contentView.safeAreaLayoutGuide.topAnchor : imageView.bottomAnchor, constant: isFirst ? 29 : 60).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: isFirst ? imageView.bottomAnchor : titleLabel.bottomAnchor, constant: isFirst ? 0 : 12).isActive = true
    }
    
}
