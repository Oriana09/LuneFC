//
//  Category.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 05/03/2024.
//

import Foundation
import UIKit
import RealmSwift

#warning("setear el placheholder")
class Category: Object {
    
    @objc dynamic var imageData: Data? = nil
    @objc dynamic var name: String = ""
//    @objc dynamic var sizes: [String] = [""]
    
    required override init() {
        super.init()
    }
    init(
        imageData: Data?,
        name: String
//        sizes: [String]
    ) {
        self.imageData = imageData
        self.name = name
//        self.sizes = sizes
        super.init()
    }
}
