//
//  AddElemetViewModel.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 20/03/2024.
//

import Foundation
import RealmSwift
import UIKit

class AddCategoryViewModel {
    
    private let realm = try! Realm()
    
    private var image: UIImage? = UIImage(named: "photo_placeholder")?.withRenderingMode(.alwaysTemplate)
    
    var numberOfSection: Int {
        
        return 3
    }
    func saveCategory() {
        let newCategory = Category(
            imageData: image?.jpegData(compressionQuality: 1),
            name: ""
        )
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(newCategory)
            }
        } catch {
            
            print("Error saving category: \(error)")
            
        }
    }
    
    func getTitle(for section: Int) -> String {
        switch section {
        case 0:
            return "Imagen"
        case 1:
            return "Titulo"
        case 2:
            return "Talle"
        default:
            return ""
        }
    }
    
    func getSelectedImage() -> UIImage? {
        return self.image
    }
    
    func setSelectedImage(image: UIImage) {
        self.image = image
    }
}

