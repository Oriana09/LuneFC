//
//  ClothingItem.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 08/02/2024.
//

import Foundation
import UIKit
import RealmSwift

class ClothingItem: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var idCode: String = ""
    @Persisted var image: Data? = nil
    @Persisted var price: Double = 0.0
    @Persisted var title: String = ""
    @Persisted var size: String = ""
    @Persisted var  style: String? = nil
    @Persisted var category: String = ""

    required override init() {
        super.init()
    }
    
    init(
        image: Data?,
        idCode: String,
        title: String,
        price: Double,
        size: String,
        style: String?,
        category: String
    ) {
        self.image = image
        self.idCode = idCode
        self.title = title
        self.price = price
        self.size = size
        self.style = style
        self.category = category
        super.init()
    }
    
    static let example = ClothingItem(
        image:  UIImage(named: "Jeans Negro")?.jpegData(compressionQuality: 1),
        idCode: "436340",
        title: "Pantalón Negro",
        price: 50.999,
        size: "38",
        style: "Azul",
        category: "Pantalones"
    )
}

