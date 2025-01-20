//
//  SearchSectionHeader.swift
//  Matule
//
//  Created by  MacBook Air on 20.01.2025.
//

import UIKit

class SearchSectionHeader: UICollectionReusableView {
    
    static let reuseID = "SearchSectionHeader"
    
    lazy var searchView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .appBlock
        $0.layer.cornerRadius = 14
        return $0
    }(UIView())
    
    lazy var searchLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Поиск"
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .appHint
        return $0
    }(UILabel())
    
    lazy var searchImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = .search
        $0.tintColor = .appHint
        return $0
    }(UIImageView())
    
    lazy var view: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 26
        $0.backgroundColor = .appAccent
        return $0
    }(UIView())
    
    lazy var iconImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = .sliders.withRenderingMode(.alwaysTemplate)
        $0.tintColor = .appBackground
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    
    lazy var sectionNameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .appText
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews(searchView, view, sectionNameLabel)
        view.addSubview(iconImage)
        searchView.addSubviews(searchImage, searchLabel)
        
        setupConstraints()
    }
    
    func setup(model: MainSectionModel) {
        sectionNameLabel.text = model.header
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchView.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -14),
            searchView.topAnchor.constraint(equalTo: topAnchor, constant: 21),
            searchView.heightAnchor.constraint(equalToConstant: 52),
            
            searchImage.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 26),
            searchImage.topAnchor.constraint(equalTo: searchView.topAnchor, constant: 14),
            searchImage.widthAnchor.constraint(equalToConstant: 24),
            searchImage.heightAnchor.constraint(equalToConstant: 24),
            
            searchLabel.leadingAnchor.constraint(equalTo: searchImage.trailingAnchor, constant: 12),
            searchLabel.topAnchor.constraint(equalTo: searchView.topAnchor, constant: 16),
            searchLabel.widthAnchor.constraint(equalToConstant: 45),
            searchLabel.heightAnchor.constraint(equalToConstant: 20),
            
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.topAnchor.constraint(equalTo: topAnchor, constant: 21),
            view.widthAnchor.constraint(equalToConstant: 52),
            view.heightAnchor.constraint(equalToConstant: 52),
            
            iconImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            iconImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 14),
            iconImage.widthAnchor.constraint(equalToConstant: 24),
            iconImage.heightAnchor.constraint(equalToConstant: 24),
            
            sectionNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            sectionNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            sectionNameLabel.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 22),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
