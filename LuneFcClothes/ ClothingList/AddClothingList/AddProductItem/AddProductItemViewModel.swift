//
//  AddProductItemViewModel.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 23/05/2024.
//

import Foundation
import RealmSwift
import UIKit

class AddProductItemViewModel {
    
    private let realm = try! Realm()
    
    private var image: UIImage? = UIImage(
        named: "photo_placeholder"
    )?.withRenderingMode(.alwaysTemplate)
    private var size: String
    private var style: String
    
    
    init(
        image: UIImage? = nil,
        size: String = "",
        style: String = ""
    ) {
        self.image = image
        self.size = size
        self.style = style
    }

    func saveProductItem() {
        let newAddProductItem = ProductItem(
            image: self.image?.jpegData(compressionQuality: 1),
            size: self.size,
            style: self.style
        )
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(newAddProductItem)
            }
        } catch {
            print("Error saving category: \(error)")
        }
    }
    
    func getTitleHeader(for section: Int) -> String {
        switch section {
        case 0:
            return "Imagen"
        case 1:
            return "Estilo"
        case 2:
            return "Talle"
        default:
            return ""
        }
    }
    
    var numberOfSection: Int {
        return 3
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        switch section {
        case SectionType.image.rawValue:
            return 1
        case SectionType.style.rawValue:
            return 1
        case SectionType.size.rawValue:
            return 1
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
    
    func getTitleHeader(section: Int) -> String {
        switch section {
        case 0:
            return "Imagén"
        case 1:
            return "Estilo"
        case 2:
            return "Talle"
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

//    func getSizes() -> String {
//        return size
//    }
//    
//    func addSizes(_ size: String) {
//        self.size.append(size)
//    }
//    
//    func getStyles() -> [String] {
//        return style
//    }
//    
//    func addStyle(_ style: String) {
//        self.style.append(style)
//    }
}

extension AddProductItemViewModel {
    
    private enum SectionType: Int {
        case image = 0
        case style = 1
        case size = 2
        
    }
}
