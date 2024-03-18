//
//  CategoryViewModel.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 07/03/2024.
//

import RealmSwift

class CategoryViewModel {
    
    private let realm = try! Realm()
    
    var categories: Results<Category>?
    
//    init(category: Category) {
//        self.category = category
//    }
   
    func save(_ category: Category) {
        try! self.realm.write {
            realm.add(category)
        }
    }

    func loadCategories()  {
        categories = realm.objects(Category.self)
        
    }
  
}

