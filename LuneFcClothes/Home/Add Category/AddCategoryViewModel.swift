//
//  AddElemetViewModel.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 20/03/2024.
//

import Foundation
import RealmSwift

class AddCategoryViewModel {
    
    private let realm = try! Realm()
    
    func saveCategory(
        name: String,
        image: Data?,
        sizes: [String]?
    ) {
        let newCategory = Category()
        newCategory.name = name
        newCategory.imageData = image
        newCategory.sizes = sizes
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(newCategory)
            }
        } catch {
            
            print("Error saving category: \(error)")
        }
    }
    
}
