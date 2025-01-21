//
//  SearchSectionHeader.swift
//  Matule
//
//  Created by  MacBook Air on 20.01.2025.
//

import UIKit

class SearchSectionHeader: UICollectionReusableView {
    
    static let reuseID = "SearchSectionHeader"
    
    lazy var leftButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(.options, for: .normal)
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIButton())
    
    lazy var titleImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = .mainController
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    lazy var additionalImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = .additional
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    
    lazy var rightButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(.bagHighlighted, for: .normal)
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIButton())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews(leftButton, additionalImage, titleImage, rightButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            leftButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            leftButton.widthAnchor.constraint(equalToConstant: 26),
            leftButton.heightAnchor.constraint(equalToConstant: 18),
            
            rightButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            rightButton.topAnchor.constraint(equalTo: topAnchor),
            rightButton.widthAnchor.constraint(equalToConstant: 44),
            rightButton.heightAnchor.constraint(equalToConstant: 44),
            
            titleImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3),
            titleImage.widthAnchor.constraint(equalToConstant: 129),
            titleImage.heightAnchor.constraint(equalToConstant: 38),
            
            additionalImage.trailingAnchor.constraint(equalTo: titleImage.leadingAnchor, constant: 5),
            additionalImage.topAnchor.constraint(equalTo: titleImage.topAnchor, constant: -11),
            additionalImage.widthAnchor.constraint(equalToConstant: 18),
            additionalImage.heightAnchor.constraint(equalToConstant: 19),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
