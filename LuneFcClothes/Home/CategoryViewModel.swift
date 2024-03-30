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
       
    func save(_ category: Category) {
        try! self.realm.write {
            self.realm.add(category)
        }
    }

    func loadCategories()  {
        self.categories = self.realm.objects(Category.self)
    }

    func deleteCategory(_ category: Category) {
        try! self.realm.write {
            self.realm.delete(category)
        }
    }

}

