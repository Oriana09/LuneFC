//
//  ClothingItemViewModel.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 08/02/2024.
//

import RealmSwift

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


