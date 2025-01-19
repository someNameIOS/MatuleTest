//
//  Label.swift
//  Matule
//
//  Created by  MacBook Air on 10.12.2024.
//

import UIKit

class Label: UILabel {
    let labelColor: UIColor
    let labelFont: UIFont
    let labelAlignment: NSTextAlignment
    let labelText: String
    let labelNumberOfLines: Int
    let labelHidden: Bool
    
    init(labelColor: UIColor = .appText, labelFont: UIFont, labelAlignment: NSTextAlignment, labelText: String = "", labelNumberOfLines: Int = 0, labelHidden: Bool = false) {
        self.labelColor = labelColor
        self.labelFont = labelFont
        self.labelAlignment = labelAlignment
        self.labelText = labelText
        self.labelNumberOfLines = labelNumberOfLines
        self.labelHidden = labelHidden
        
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        sizeToFit()
        textColor = labelColor
        font = labelFont
        textAlignment = labelAlignment
        text = labelText
        numberOfLines = labelNumberOfLines
        isHidden = labelHidden
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
