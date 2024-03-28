//
//  ClothingItem.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 08/02/2024.
//

import Foundation
import UIKit
import RealmSwift

class ClothingItem: Object {
    @objc dynamic var image: Data? = nil
    @objc dynamic var price: Double = 0.0
    @objc dynamic var title: String = ""
    @objc dynamic var stockQuantity: Int = 0
    @objc dynamic var category: String = ""
}
