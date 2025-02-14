//
//  Label.swift
//  Matule
//
//  Created by  MacBook Air on 10.12.2024.
//

import UIKit

class Label: UILabel {
    let labelText: String
    let labelAlignment: NSTextAlignment
    let labelFont: UIFont
    let labelColor: UIColor
    let labelHidden: Bool
    let labelNumberOfLines: Int
    
    init(labelText: String, labelAlignment: NSTextAlignment = .center, labelFont: UIFont = .systemFont(ofSize: 16, weight: .regular), labelColor: UIColor, labelHidden: Bool = false, labelNumberOfLines: Int = 0) {
        self.labelText = labelText
        self.labelAlignment = labelAlignment
        self.labelFont = labelFont
        self.labelColor = labelColor
        self.labelHidden = labelHidden
        self.labelNumberOfLines = labelNumberOfLines
        
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        sizeToFit()
        text = labelText
        textAlignment = labelAlignment
        font = labelFont
        textColor = labelColor
        isHidden = labelHidden
        numberOfLines = labelNumberOfLines
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

