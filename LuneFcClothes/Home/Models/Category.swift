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
    @objc dynamic var imageData: Data? = nil
    @objc dynamic var name: String = ""
    
  //  let placeholderData: Data = (UIImage(named: "campera")?.jpegData(compressionQuality: 1.0))!
}
