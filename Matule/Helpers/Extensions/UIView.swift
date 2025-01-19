//
//  UIView.swift
//  Matule
//
//  Created by  MacBook Air on 10.12.2024.
//

import UIKit

extension UIView {
    public func addSubviews(_ views: UIView...) {
        views.forEach(addSubview)
    }
}

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
}
