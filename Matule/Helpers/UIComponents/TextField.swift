//
//  TextFiels.swift
//  Matule
//
//  Created by  MacBook Air on 16.02.2025.
//

import UIKit

extension UITextField {
    static func textField(placeholder: String, font: UIFont = .systemFont(ofSize: 14, weight: .regular), textColor: UIColor = .appHint, backgroundColor: UIColor = .appBackground, layerCornerRadius: CGFloat = 14, isSecurityTextEntry: Bool = false, leftView: UIView? = nil, leftViewMode: UITextField.ViewMode = .never, rightView: UIView? = nil, rightViewMode: UITextField.ViewMode = .never) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = isSecurityTextEntry
        textField.placeholder = placeholder
        textField.textColor = textColor
        textField.backgroundColor = backgroundColor
        textField.layer.cornerRadius = layerCornerRadius
        textField.leftView = leftView
        textField.leftViewMode = leftViewMode
        textField.rightView = rightView
        textField.rightViewMode = rightViewMode
        return textField
    }
}
