//
//  FIrstOnboard.swift
//  Matule
//
//  Created by  MacBook Air on 15.12.2024.
//

import UIKit

//MARK: View
class OnboardViewController: UIViewController {
    
    let model: [OnboardModel] = OnboardModel.mockData
    var currentSlide = 0
    var isFirst: Bool = true
    
    private var firstViewWidthConstraint: NSLayoutConstraint?
    private var secondViewWidthConstraint: NSLayoutConstraint?
    private var thirdViewWidthConstraint: NSLayoutConstraint?
    
    lazy var layout: UICollectionViewFlowLayout = {
        $0.scrollDirection = .horizontal
        $0.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        $0.minimumLineSpacing = 0
        return $0
    }(UICollectionViewFlowLayout())
    
    lazy var collectionView: UICollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.dataSource = self
        $0.delegate = self
        $0.register(OnboardCollectionCell.self, forCellWithReuseIdentifier: OnboardCollectionCell.reuseID)
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.alwaysBounceVertical = false
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.isScrollEnabled = false
        return $0
    }(UICollectionView(frame: view.frame, collectionViewLayout: layout))
    
    lazy var firstView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 2.5
        $0.heightAnchor.constraint(equalToConstant: 5).isActive = true
        return $0
    }(UIView())
    
    lazy var secondView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 2.5
        $0.heightAnchor.constraint(equalToConstant: 5).isActive = true
        return $0
    }(UIView())
    
    lazy var thirdView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 2.5
        $0.heightAnchor.constraint(equalToConstant: 5).isActive = true
        return $0
    }(UIView())
    
    lazy var nextButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 13
        $0.backgroundColor = .appBlock
        $0.setTitleColor(.appText, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        $0.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.appAccent.cgColor, UIColor.appSecondGradient.cgColor, UIColor.appThirdGradient.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        view.layer.addSublayer(gradientLayer)
        
        view.addSubviews(collectionView, nextButton)
        setupConstraints()
        setControll()
    }
    
    private func setControll() {
        let pagerStack = UIStackView()
        pagerStack.translatesAutoresizingMaskIntoConstraints = false
        pagerStack.axis = .horizontal
        pagerStack.spacing = 12
        pagerStack.distribution = .equalSpacing
        pagerStack.alignment = .center
        pagerStack.addArrangedSubview(firstView)
        pagerStack.addArrangedSubview(secondView)
        pagerStack.addArrangedSubview(thirdView)
        view.addSubview(pagerStack)

        NSLayoutConstraint.activate([
            pagerStack.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -80),
            pagerStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pagerStack.widthAnchor.constraint(equalToConstant: 123),
            pagerStack.heightAnchor.constraint(equalToConstant: 5),
        ])
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -36),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func configure(isFirst: Bool, isSecond: Bool, isThird: Bool) {
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
    }
        
}

extension OnboardViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardCollectionCell.reuseID, for:  indexPath) as! OnboardCollectionCell
        
        let item = model[indexPath.item]
        cell.configure(with: item, isFirst: indexPath.item == 0)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        currentSlide = indexPath.item
        isFirst = indexPath.item == 0
        nextButton.setTitle(isFirst ? "Начать" : "Далее", for: .normal)
        configure(
            isFirst: indexPath.item == 0,
            isSecond: indexPath.item == 1,
            isThird: indexPath.item == 2
        )

    }
}

//MARK: Controller
extension OnboardViewController {
    
    @objc private func nextButtonTapped() {
        let maxSlide = model.count - 1
        
        if currentSlide < maxSlide {
            currentSlide += 1
            collectionView.scrollToItem(at: IndexPath(item: currentSlide, section: 0), at: .centeredHorizontally, animated: true)
        } else if currentSlide == maxSlide {
            let nextVC = LogInViewController()
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate,
               let window = sceneDelegate.window {
                window.rootViewController = nextVC
                UIView.transition(with: window, duration: 0.1, options: .autoreverse, animations: nil)
            }
        }
        
    }

}
