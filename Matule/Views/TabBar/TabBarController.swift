//
//  TabBarController.swift
//  Matule
//
//  Created by  MacBook Air on 03.02.2025.
//

import UIKit

class TabBarController: UITabBarController {
    
    lazy var image: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = .tabBarView
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    
    lazy var mainStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalSpacing
        $0.addArrangedSubview(leftStack)
        $0.addArrangedSubview(rightStack)
        return $0
    }(UIStackView())
    
    lazy var bagButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .appAccent
        $0.setImage(.bag, for: .normal)
        $0.layer.cornerRadius = 28
        $0.layer.shadowColor = UIColor(red: 91/255, green: 158/255, blue: 225/255, alpha: 1).cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 8)
        $0.layer.shadowRadius = 24
        $0.layer.shadowOpacity = 1
        return $0
    }(UIButton())
    
    lazy var leftStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalSpacing
        $0.addArrangedSubview(mainButton)
        $0.addArrangedSubview(favouriteButton)
        return $0
    }(UIStackView())
    
    lazy var mainButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(.home.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.addTarget(self, action: #selector(mainTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    lazy var favouriteButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(.favorite.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    lazy var rightStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalSpacing
        $0.addArrangedSubview(notificationButton)
        $0.addArrangedSubview(profileButton)
        return $0
    }(UIStackView())
    
    lazy var notificationButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(.notification.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .appSubTextDark
        $0.addTarget(self, action: #selector(notificationTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    lazy var profileButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(.profile.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .appSubTextDark
        $0.addTarget(self, action: #selector(profileTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isHidden = true
        
        setupViewControllers()
        view.addSubviews(image, mainStack, bagButton)
        setupConstraints()
        updateButtonSelection(selectedButton: mainButton)
    }
    
    private func setupViewControllers() {
        let homeVC = MainViewController()
        let favoriteVC = FavouritesViewController()

        viewControllers = [homeVC, favoriteVC]
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            image.heightAnchor.constraint(equalToConstant: 106),
            
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -31),
            mainStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            mainStack.heightAnchor.constraint(equalToConstant: 24),
            
            bagButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            bagButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bagButton.widthAnchor.constraint(equalToConstant: 56),
            bagButton.heightAnchor.constraint(equalToConstant: 56),
            
            leftStack.widthAnchor.constraint(equalToConstant: 87),
            leftStack.heightAnchor.constraint(equalToConstant: 24),
            
            rightStack.widthAnchor.constraint(equalToConstant: 87),
            rightStack.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
    
}

extension TabBarController {
    @objc func mainTapped() {
        selectedIndex = 0
        updateButtonSelection(selectedButton: mainButton)
    }
    
    @objc func favoriteTapped() {
        selectedIndex = 1
        updateButtonSelection(selectedButton: favouriteButton)
    }
    
    @objc func notificationTapped() {
    }
    
    @objc func profileTapped() {
    }
    
    private func updateButtonSelection(selectedButton: UIButton) {
        let allButtons = [mainButton, favouriteButton]
        
        for button in allButtons {
            button.tintColor = .appSubTextDark
        }
        
        selectedButton.tintColor = .appAccent
    }
    
}
