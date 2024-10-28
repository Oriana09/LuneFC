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
    
    var clothins: [ClothingItem] = []
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
    
    func loadItems()  {

    
        self.items = realm.objects(ClothingItem.self).filter("category == %@", self.category.name)

    }
    
    func deleteClothinList(_ clothingItem: ClothingItem) {
        try! self.realm.write {
            self.realm.delete(clothingItem)
        }
    }
    
    func loadSameProduct() {
       
        
        let allProducts = realm.objects(ClothingItem.self)
        print("Cantidad total de productos en Realm antes de filtrar: \(allProducts.count)")
      
        for product in allProducts {
               print("Producto en Realm - Código: \(product.idCode), Título: \(product.title), Precio: \(product.price)")
           }
           
        var sameIdCodes = [String: ClothingItem]()
        
        for product in allProducts {
            if sameIdCodes[product.idCode] == nil {
                sameIdCodes[product.idCode] = product
            }
        }
        self.clothins = Array(sameIdCodes.values)
        
        
        print("Productos únicos encontrados: \(clothins.count)")
    }
}
