//
//  FIrstOnboard.swift
//  Matule
//
//  Created by  MacBook Air on 15.12.2024.
//

import UIKit

//MARK: View
class OnboardViewController: UIViewController {
    
    var model: [OnboardModel] = OnboardModel.mockData
    
    var currentSlide: Int = 0
    
    lazy var layout: UICollectionViewFlowLayout = {
        $0.scrollDirection = .horizontal
        $0.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        $0.minimumLineSpacing = 0
        return $0
    }(UICollectionViewFlowLayout())
    
    lazy var collectionView: UICollectionView = {
        $0.dataSource = self
        $0.delegate = self
        $0.register(OnboardCollectionCell.self, forCellWithReuseIdentifier: OnboardCollectionCell.reuseID)
        $0.showsHorizontalScrollIndicator = false
        $0.isScrollEnabled = false
        return $0
    }(UICollectionView(frame: view.frame, collectionViewLayout: layout))
    
    lazy var nextButton: UIButton = UIButton.button(backgroundColor: .appBlock,title: "Начать", titleColor: .appText, target: self, selector: #selector(buttonTapped))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubviews(collectionView, nextButton)
        setupConstraints()
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -36),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}

extension OnboardViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = model[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardCollectionCell.reuseID, for: indexPath) as! OnboardCollectionCell
        cell.config(model: item, isFirst: indexPath.item == 0, isSecond: indexPath.item == 1, isThird: indexPath.item == 2)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        currentSlide = indexPath.item
        let isFirst = indexPath.item == 0
        nextButton.setTitle(isFirst ? "Начать" : "Далее", for: .normal)
    }
}

//MARK: Controller
extension OnboardViewController {
    @objc private func buttonTapped() {
        let maxSlide = model.count - 1
        
        if currentSlide < maxSlide {
            currentSlide += 1
            collectionView.scrollToItem(at: IndexPath(item: currentSlide, section: 0), at: .centeredHorizontally, animated: true)
        } else if currentSlide == maxSlide {
            let nextVC = LogInViewController()
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate, let window = sceneDelegate.window {
                window.rootViewController = nextVC
                window.makeKeyAndVisible()
            }
        }
    }
}
