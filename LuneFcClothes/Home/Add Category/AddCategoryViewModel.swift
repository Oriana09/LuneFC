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
        image: Data?
    ) {
        let nuevaCategoria = Category()
        nuevaCategoria.name = name
        nuevaCategoria.imageData = image
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(nuevaCategoria)
            }
        } catch {
            
            print("Error al guardar la categoría: \(error)")
        }
    }
}
