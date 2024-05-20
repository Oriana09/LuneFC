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
        
        guard realm.objects(ClothingItem.self).isEmpty else { return }
        
        let defaultItems: [ClothingItem] = [
            ClothingItem(
                image: UIImage(named: "Jeans Wid Leg")?.jpegData(compressionQuality: 1),
                idCode: "436340",
                title: "Pantalón Wid Leg",
                price: 50.999,
                size: "38",
                category: "Pantalones"
            ),
            ClothingItem(
                image: UIImage(named: "Jeans Negro")?.jpegData(compressionQuality: 1),
                idCode: "436341",
                title: "Pantalón Negro",
                price: 45.599,
                size: "40",
                category: "Pantalones"
            ),
            ClothingItem(
                image: UIImage(named: "Jeans recto")?.jpegData(compressionQuality: 1),
                idCode: "ori436342",
                title: "Pantalón Recto",
                price: 44.999,
                size: "42",
                category: "Pantalones"
            ),
            ClothingItem(
                image: UIImage(named: "Jeans Mom")?.jpegData(compressionQuality: 1),
                idCode: "436342",
                title: "Pantalón Mom",
                price: 20.755,
                size: "40",
                category: "Pantalones"
            ),
            ClothingItem(
                image: UIImage(named: "Jeans Wid Leg")?.jpegData(compressionQuality: 1),
                idCode: "436349",
                title: "Pantalón Wid Leg",
                price: 50.999,
                size: "38",
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


