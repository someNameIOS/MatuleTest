//
//  OnboardCollectionCell.swift
//  Matule
//
//  Created by  MacBook Air on 15.12.2024.
//

import UIKit

class OnboardCollectionCell: UICollectionViewCell {
    
    static var reuseID: String = "Cell"
    
    var firstViewWidthConstraint: NSLayoutConstraint?
    var secondViewWidthConstraint: NSLayoutConstraint?
    var thirdViewWidthConstraint: NSLayoutConstraint?
    
    lazy var titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 30, weight: .regular)
        $0.numberOfLines = 0
        $0.textColor = .appBlock
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    lazy var imageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    
    lazy var descriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.numberOfLines = 0
        $0.textColor = .appSubTextLight
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    lazy var stack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .center
        $0.spacing = 12
        $0.addArrangedSubview(firstView)
        $0.addArrangedSubview(secondView)
        $0.addArrangedSubview(thirdView)
        return $0
    }(UIStackView())
    
    lazy var firstView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 5).isActive = true
        $0.layer.cornerRadius = 2.5
        return $0
    }(UIView())
    
    lazy var secondView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 5).isActive = true
        $0.layer.cornerRadius = 2.5
        return $0
    }(UIView())
    
    lazy var thirdView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 5).isActive = true
        $0.layer.cornerRadius = 2.5
        return $0
    }(UIView())
    
    lazy var gradient: CAGradientLayer = {
        $0.frame = bounds
        $0.colors = [UIColor.appAccent.cgColor, UIColor.appSecondGradient.cgColor]
        $0.startPoint = CGPoint(x: 0.5, y: 0.0)
        $0.endPoint = CGPoint(x: 0.5, y: 1.0)
        return $0
    }(CAGradientLayer())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.addSublayer(gradient)
        
        addSubviews(titleLabel, imageView, descriptionLabel, stack)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 302),
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.widthAnchor.constraint(equalToConstant: 123),
            stack.heightAnchor.constraint(equalToConstant: 5)
        ])
    }
    
    func config(model: OnboardModel, isFirst: Bool, isSecond: Bool, isThird: Bool) {
        imageView.image = UIImage(named: model.imageName)
        titleLabel.text = model.title
        descriptionLabel.text = model.description
                
        titleLabel.font = .systemFont(ofSize: isFirst ? 30 : 34)
        
        firstView.backgroundColor = isFirst ? .appBlock : .appDisable
        secondView.backgroundColor = isSecond ? .appBlock : .appDisable
        thirdView.backgroundColor = isThird ? .appBlock : .appDisable
        
        firstViewWidthConstraint?.isActive = false
        secondViewWidthConstraint?.isActive = false
        thirdViewWidthConstraint?.isActive = false
        
        firstViewWidthConstraint = firstView.widthAnchor.constraint(equalToConstant: isFirst ? 43 : 28)
        secondViewWidthConstraint = secondView.widthAnchor.constraint(equalToConstant: isSecond ? 43 : 28)
        thirdViewWidthConstraint = thirdView.widthAnchor.constraint(equalToConstant: isThird ? 43 : 28)
        
        firstViewWidthConstraint?.isActive = true
        secondViewWidthConstraint?.isActive = true
        thirdViewWidthConstraint?.isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: isFirst ? safeAreaLayoutGuide.topAnchor : imageView.bottomAnchor, constant: isFirst ? 29 : 60).isActive = true
        imageView.topAnchor.constraint(equalTo: isFirst ? titleLabel.bottomAnchor : topAnchor, constant: isFirst ? 130 : 37).isActive = true
        stack.topAnchor.constraint(equalTo: isFirst ? imageView.bottomAnchor : descriptionLabel.bottomAnchor, constant: isFirst ? 26 : 40).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
