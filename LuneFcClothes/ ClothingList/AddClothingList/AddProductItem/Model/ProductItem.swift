//
//  AddProductoItem.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 23/05/2024.
//

import Foundation
import RealmSwift

class ProductItem: Object {
    @objc dynamic var image: Data? = nil
    @objc dynamic var size: String = ""
    @objc dynamic var style: String = ""
    
    
    
    required override init() {
        super.init()
    }
    
    init(
        image: Data?,
        size: String = "",
        style: String = ""
    ){
        self.image = image
        self.size = size
        self.style = style
        super.init()
    }
}



