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
    @objc dynamic var idCode: String? = nil
    @objc dynamic var image: Data? = nil
    @objc dynamic var price: Double = 0.0
    @objc dynamic var title: String = ""
    @objc dynamic var size: String = ""
    @objc dynamic var category: String = ""
    
    required override init() {
        super.init()
    }
    
    init(
        idCode: String?,
        image: Data?,
        price: Double,
        size: String,
        title: String,
        category: String
    ) {
        self.idCode = idCode
        self.image = image
        self.price = price
        self.size = size
        self.title = title
        self.category = category
        super.init()
    }
//
//    enum Size: Int {
//        case s: 
//    }
}
