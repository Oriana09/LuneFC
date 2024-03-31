//
//  UIIHelper.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 09/02/2024.
//

import Foundation
import UIKit

#warning("configurar la celdas para que tengan mas especios y refactorizar este codigo")


enum UIHelper {
    
    static func createTwoColumnFlowLayout() -> UICollectionViewLayout {
        
        let padding: CGFloat = 16.0
        let minimumInteritemSpacing: CGFloat = 10.0
        let availableWidth = UIScreen.main.bounds.width - padding * 2
        let numberOfColumns = calculateNumberOfColumns(for: availableWidth)
        let itemWidth = calculateItemWidth(
            for: availableWidth,
            numberOfColumns: numberOfColumns,
            minimumInteritemSpacing: minimumInteritemSpacing
        )
        
        let layout = UICollectionViewFlowLayout()
        setupFlowLayout(
            layout,
            itemWidth: itemWidth,
            minimumInteritemSpacing: minimumInteritemSpacing,
            padding: padding
        )
        return layout
    }
    
    private static func calculateNumberOfColumns(for availableWidth: CGFloat) -> CGFloat {
        return availableWidth > 500 ? 3 : 2
    }
    
    private static func calculateItemWidth(for availableWidth: CGFloat, numberOfColumns: CGFloat, minimumInteritemSpacing: CGFloat) -> CGFloat {
        return (availableWidth - (numberOfColumns - 1) * minimumInteritemSpacing) / numberOfColumns
    }
    
    private static func setupFlowLayout(_ layout: UICollectionViewFlowLayout, itemWidth: CGFloat, minimumInteritemSpacing: CGFloat, padding: CGFloat) {
        
        layout.itemSize = CGSize(
            width: itemWidth,
            height: itemWidth
        )
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        layout.minimumLineSpacing = minimumInteritemSpacing
        layout.sectionInset = UIEdgeInsets(
            top: padding,
            left: padding,
            bottom: padding,
            right: padding
        )
        layout.scrollDirection = .vertical
    }
}



//enum UIHelper {
//    
//    static func createTwoColumnFlowLayout() -> UICollectionViewLayout {
//       
//        let padding = 16.0
//
//        let layout = UICollectionViewFlowLayout()
//        let availableWidth = (UIScreen.main.bounds.width - padding * 2)
//        let screenIsBig = availableWidth > 500
//        let numberOfColumns: CGFloat = screenIsBig ? 3 : 2
//        let itemWidth = (availableWidth - (numberOfColumns - 1)) / numberOfColumns
//        layout.itemSize = CGSize(
//            width: itemWidth,
//            height: itemWidth
//        )
//        layout.minimumInteritemSpacing = 1
//        layout.minimumLineSpacing = 1
//        layout.sectionInset = UIEdgeInsets(
//            top: padding,
//            left: padding,
//            bottom: 0,
//            right: padding
//        )
//        layout.scrollDirection = .vertical
//        return layout
//    }
//}
