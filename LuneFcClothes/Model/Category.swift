//
//  Category.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 05/03/2024.
//

import Foundation
import UIKit
import RealmSwift

class Category: Object {
    @objc dynamic var image: Data? = nil
    @objc dynamic var name: String = ""
}


//struct Category {
//    let image: String
//    let name: String
//}

//var categories = [
//Category(image: "musculosa", name: "Remeras/tops"),
//Category(image: "pantalon",  name: "Pantalones"),
//Category(image: "camisa",    name: "Camisas"),
//Category(image: "buzo",      name: "Buzos/Sweters"),
//Category(image: "short",     name: "Shorts"),
//Category(image: "falda",     name: "Faldas"),
//Category(image: "campera",   name: "Camperas")
//]
