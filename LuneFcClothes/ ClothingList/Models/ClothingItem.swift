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
    @objc dynamic var idCode: String = ""
    @objc dynamic var image: Data? = nil
    @objc dynamic var price: Double = 0.0
    @objc dynamic var title: String = ""
    @objc dynamic var size: String = ""
//    @objc dynamic var type: String = ""
    @objc dynamic var category: String = ""
    
    required override init() {
        super.init()
    }
    
    init(
        image: Data?,
        idCode: String,
        title: String,
        price: Double,
        size: String,
//        type: String,
        category: String
    ) {
        self.image = image
        self.idCode = idCode
        self.title = title
        self.price = price
        self.size = size
//        self.type = type
        self.category = category
        super.init()
    }
}
