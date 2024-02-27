//
//  ClothingItemViewModel.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 08/02/2024.
//

import Foundation
import UIKit

class ClothingItemViewModel {
    let clothingItems: [ClothingItem] = [
        ClothingItem(image: UIImage(named: "musculosa")!, price: 40, title: "Remeras/tops" , talle: 1),
        ClothingItem (image: UIImage(named: "musculosa")!, price: 40, title: "Camisas" , talle: 1),
        ClothingItem(image: UIImage(named: "pantalon")!, price: 11, title: "Short", talle: 1),
        ClothingItem(image: UIImage(named: "pantalon")!, price: 22, title: "Faldas", talle: 1),
        ClothingItem(image: UIImage(named: "pantalon")!, price: 33, title: "Pantalones", talle: 2),
        ClothingItem(image:  UIImage(named: "buzo 2")!, price: 22, title: "Camperas", talle: 1),
        ClothingItem(image: UIImage(named: "buzo 2")!, price: 11, title: "Buzos", talle: 1)
    ]
}


