//
//  ClothingItem.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 08/02/2024.
//

import Foundation
import UIKit

struct ClothingItem {
    let image: String
    let price: Double
    let title: String
    let stockQuantity: Int
    let category: String
}


var clothingItems = [
    ClothingItem(image: "musculosa", price: 20.99, title: "top morley combinado blanco y negro", stockQuantity: 2, category: "Remeras/tops"),
    ClothingItem(image:  "pantalon", price: 30.222, title: "pantalone Skater Fit", stockQuantity: 4,  category: "Pantalones"),
    ClothingItem(image:  "camisa", price: 20.999, title: "camisa", stockQuantity: 1, category: "Camisas"),
    ClothingItem(image:  "buzo", price: 40.00, title: "Sweters naranja", stockQuantity: 3,  category: "Buzos/Sweters"),
    ClothingItem(image: "short", price: 400.0, title: "short mom", stockQuantity: 9, category: "Shorts"),
    ClothingItem(image: "falda", price: 33.00, title: "falda", stockQuantity: 2, category: "Faldas"),
    ClothingItem(image:"campera", price: 30.00, title: "campera jeans", stockQuantity: 3, category: "Camperas"),
    ClothingItem(image:"musculosa", price: 30.00, title: "campera jeans", stockQuantity: 3, category: "Camperas")
]
