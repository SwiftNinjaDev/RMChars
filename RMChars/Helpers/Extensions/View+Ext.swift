//
//  View+Ext.swift
//  RMChars
//
//  Created by Nikolai Kharkevich on 02.05.2024.
//

import UIKit

public extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
    }
    
    func roundCorners() {
        roundCorners(.allCorners, radius: frame.height / 2)
    }
}
