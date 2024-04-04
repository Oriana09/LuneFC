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
            // Verifica si ya hay elementos guardados
            guard realm.objects(ClothingItem.self).isEmpty else { return }
            
            // Si no hay elementos guardados, guarda algunos elementos predefinidos
            let defaultItems: [(String, Double, Data?)] = [
                ("Pantalón 1", 29.99, UIImage(named: "pantalon1")?.pngData()),
                ("Pantalón 2", 39.99, UIImage(named: "pantalon2")?.pngData()),
                // Añade más elementos según sea necesario
            ]
            
            // Guarda los elementos predefinidos
            try! realm.write {
                for (title, price, imageData) in defaultItems {
                    let newItem = ClothingItem()
                    newItem.title = title
                    newItem.price = price
                    newItem.image = imageData
                    newItem.category = category.name // Asigna la categoría actual
                    
                    realm.add(newItem)
                }
            }
        }
    
    func saveItems(_ clothingItem: ClothingItem) {
        try! self.realm.write {
            realm.add(clothingItem)
        }
    }
    
    func loadItems() {
        
        // Filtrar los objetos ClothingItem por el nombre de la categoría seleccionada
        self.items = realm.objects(ClothingItem.self).filter("category == %@", self.category.name)
    }
    
    
}


