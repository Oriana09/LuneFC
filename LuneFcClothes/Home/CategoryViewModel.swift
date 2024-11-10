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
    
    func loadCategories()  {
        self.categories = self.realm.objects(Category.self)
    }
    
    func deleteCategory(_ category: Category) {
        
        do {
            try self.realm.write {
                self.realm.delete(category)
            }
        } catch {
            print("Error deleting category: \(error)")
        }
        
    
//        try! self.realm.write {
//            self.realm.delete(category)
//        }
    }
}

