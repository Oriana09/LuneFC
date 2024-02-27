//
//  UIIHelper.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 09/02/2024.
//

import Foundation
import UIKit

enum UIHelper {
    
    static  func createTwoColumnFlowLayout()-> UICollectionViewLayout {
        let padding = 16.0
        
        let layout = UICollectionViewFlowLayout()
        let availableWidth              = (UIScreen.main.bounds.width - padding * 2)
        let screenIsBig                 = availableWidth > 500
        let numberOfColumns: CGFloat    = screenIsBig ? 3 : 2
        let itemWidth                   = (availableWidth - (numberOfColumns - 1)) / numberOfColumns // Calcula el ancho de cada celda
        // Establece el tamaño de cada celda
        layout.itemSize                 = CGSize(width: itemWidth,
                                                 height: itemWidth)
        layout.minimumInteritemSpacing  = 1
        layout.minimumLineSpacing       = 1
        layout.sectionInset             = UIEdgeInsets(top: padding,
                                                       left: padding,
                                                       bottom: 0,
                                                       right: padding)
        layout.scrollDirection          = .vertical
        return layout
    }
}
