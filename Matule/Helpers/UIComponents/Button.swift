//
//  Button.swift
//  Matule
//
//  Created by  MacBook Air on 16.02.2025.
//

import UIKit

extension UIButton {
    static func button(backgroundColor: UIColor = .appAccent, title: String, layerCornerRadius: CGFloat = 14, titleColor: UIColor = .appBlock, titleFont: UIFont = .systemFont(ofSize: 14, weight: .regular), target: Any?, selector: Selector?) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = layerCornerRadius
        button.titleLabel?.font = titleFont
        button.setTitleColor(titleColor, for: .normal)
        button.setTitle(title, for: .normal)
        if let selector = selector {
            button.addTarget(target, action: selector, for: .touchUpInside)
        }
        return button
    }
}

//    $0.translatesAutoresizingMaskIntoConstraints = false
//    $0.backgroundColor = .appBlock
//    $0.layer.cornerRadius = 13
//    $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
//    $0.setTitleColor(.appText, for: .normal)
//    $0.setTitle("Начать", for: .normal)
//    $0.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
