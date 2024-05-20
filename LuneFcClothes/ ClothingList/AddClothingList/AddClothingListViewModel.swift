//
//  AddClothingListViewModel.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 08/04/2024.
//

import Foundation
import RealmSwift
import UIKit

class AddClothingListViewModel {
    
    private let realm = try! Realm()
    
    private var image: UIImage? = UIImage(
        named: "photo_placeholder"
    )?.withRenderingMode(.alwaysTemplate)
    private var idCode: String
    private var title: String
    private var price: Double
    private var size: String
    private var category: Category
    
    init(
        image: UIImage? = nil,
        idCode: String = "",
        title: String = "",
        price: Double = 0.0,
        size: String = "",
        category: Category
    ) {
        self.image = image
        self.idCode = idCode
        self.title = title
        self.price = price
        self.size = size
        self.category = category
    }
    
    func saveClothingItem() {
        let newAddClothingList = ClothingItem(
            image: self.image?.jpegData(compressionQuality: 1),
            idCode: self.idCode,
            title: self.title,
            price: self.price,
            size: self.size, 
            category: self.category.name
        )
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(newAddClothingList)
            }
        } catch {
            
            print("Error saving category: \(error)")
        }
    }
       
    func getTitleHeader(for section: Int) -> String {
        switch section {
        case 0:
            return "Imagén"
        case 1:
            return "Código"
        case 2:
            return "Título"
        case 3:
            return "Precio"
        case 4:
            return "Cantidad"
        default:
            return ""
        }
    }
    
    func getTitleFooter(for section: Int) -> String {
        switch section {
        case 0:
            return "Toque para agregar imagen"
        case 1:
            return ""
        case 2:
            return ""
        default:
            return ""
            
        }
    }
    
    var numberOfSection: Int {
        return 5
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        switch section {
        case SectionType.image.rawValue:
            return 1
        case SectionType.idCode.rawValue:
            return 1
        case SectionType.title.rawValue:
            return 1
        case SectionType.price.rawValue:
            return 1
        case SectionType.quantity.rawValue:
            return self.category.sizes.count
        default:
            return 0
        }
    }
    
    func getSelectedImage() -> UIImage? {
        return self.image
    }
    
    func setSelectedImage(image: UIImage) {
        self.image = image
    }
    
    func getTitle(index: IndexPath) -> String {
     
        switch index.section {
        
        case 1:
            return self.idCode
         
        case 2:
            return self.title
        case 3:
            return String(self.price)
        case 4:
            return self.size
        default:
            return ""
        }
    }
    
    func setTitle(_ title: String, index: IndexPath) {
        switch index.section {
        case 1:
            self.idCode = title
        case 2:
            self.title = title
        case 3:
            if let price = Double(title) {
                self.price = price
            } else {
                print("Show error in VC")
            }
        case 4:
            self.size = title
        default: break
            
        }
    }
}

extension AddClothingListViewModel {
    
    private enum SectionType: Int {
        case image = 0
        case idCode = 1
        case title = 2
        case price = 3
        case quantity = 4
    }
}
