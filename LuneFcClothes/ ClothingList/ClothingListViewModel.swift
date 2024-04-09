//
//  ClothingItemViewModel.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 08/02/2024.
//

import RealmSwift
import Foundation
import UIKit

class ClothingListViewModel {
    
    private let realm = try! Realm()
    
    var items: Results<ClothingItem>?
    var category: Category
    
    init(
        items: Results<ClothingItem>? = nil,
        category: Category
    ) {
        self.items = items
        self.category = category
        
        self.saveDefaultItems()
    }
    
    private func saveDefaultItems() {
        
        //        guard realm.objects(ClothingItem.self).isEmpty else { return }
        
        let defaultItems: [ClothingItem] = [
            ClothingItem(
                idCode: "436340",
                image: UIImage(named: "Jeans Wid Leg")?.jpegData(compressionQuality: 1),
                price: 50.999,
                size: "38",
                title: "Pantalón Wid Leg",
                category: "Pantalones"
            ),
            ClothingItem(
                idCode: "436341",
                image: UIImage(named: "Jeans Negro")?.jpegData(compressionQuality: 1),
                price: 45.599,
                size: "40",
                title: "Pantalón Negro",
                category: "Pantalones"
            ),
            ClothingItem(
                idCode: "436342",
                image: UIImage(named: "Jeans recto")?.jpegData(compressionQuality: 1),
                price: 44.999,
                size: "42",
                title: "Pantalón Recto",
                category: "Pantalones"
            ),
            ClothingItem(
                idCode: "436342",
                image: UIImage(named: "Jeans Mom")?.jpegData(compressionQuality: 1),
                price: 20.755,
                size: "40",
                title: "Pantalón Mom",
                category: "Pantalones"
            ),
            ClothingItem(
                idCode: "436349",
                image: UIImage(named: "Jeans Wid Leg")?.jpegData(compressionQuality: 1),
                price: 50.999,
                size: "38",
                title: "Pantalón Wid Leg",
                category: "Pantalones"
            ),
        ]
        
        try! realm.write {
            realm.add(defaultItems)
        }
    }
    
    func saveItems(_ clothingItem: ClothingItem) {
        try! self.realm.write {
            realm.add(clothingItem)
        }
    }
    
    func loadItems() {
        self.items = realm.objects(ClothingItem.self).filter("category == %@", self.category.name)
    }
    
    func deleteClothinList(_ clothingItem: ClothingItem) {
        try! self.realm.write {
            self.realm.delete(clothingItem)
        }
    }
}


