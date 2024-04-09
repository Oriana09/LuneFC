//
//  AddClothingListViewModel.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 08/04/2024.
//

import Foundation
import RealmSwift

class AddClothingListViewModel {
    
    private let realm = try! Realm()
    
   
    func saveClothingList(
        idCode: String?,
        imageData: Data?,
        price: Double,
        title: String,
        size: String,
        category: String
    ) {
        
        let newAddClothingList = ClothingItem()
        newAddClothingList.idCode = idCode
        newAddClothingList.image = imageData
        newAddClothingList.price = price
        newAddClothingList.title = title
        newAddClothingList.size = size
        newAddClothingList.category = category
        
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(newAddClothingList)
            }
        } catch {
            
            print("Error saving category: \(error)")
        }
    }
}
