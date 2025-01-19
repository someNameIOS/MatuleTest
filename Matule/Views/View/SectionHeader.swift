//
//  SectionHeader.swift
//  Matule
//
//  Created by  MacBook Air on 15.01.2025.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    
    static let reuseID = "SectionHeader"
    
    lazy var hStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .center
        $0.addArrangedSubview(headerLabel)
        $0.addArrangedSubview(headerButton)
        return $0
    }(UIStackView())
    
    lazy var headerLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .appText
        $0.textAlignment = .left
        $0.sizeToFit()
        return $0
    }(UILabel())
    
    lazy var headerButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        $0.setTitleColor(.appAccent, for: .normal)
        $0.titleLabel?.textAlignment = .right
        return $0
    }(UIButton())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(hStack)
        
        setupConstraints()
    }
    
    func setup(model: MainSectionModel, type: HeaderType) {
        headerLabel.text = model.header
        switch type {
        case .popular: headerButton.setTitle("Все", for: .normal)
        case .stock: headerButton.setTitle("Все", for: .normal)
        default: headerButton.setImage(UIImage(systemName: ""), for: .normal)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            hStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            hStack.topAnchor.constraint(equalTo: topAnchor),
            
            headerButton.widthAnchor.constraint(equalToConstant: 30),
            headerButton.heightAnchor.constraint(equalToConstant: 19),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
