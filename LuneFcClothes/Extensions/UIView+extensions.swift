//
//  UIView+extensions.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 16/02/2024.
//

import Foundation
import UIKit


extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
