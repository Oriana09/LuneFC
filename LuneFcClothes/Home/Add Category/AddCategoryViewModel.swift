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
    private var image: UIImage?
    private var title: String = ""
    
    var sizes: [String] = [""]
    
    var numberOfSection: Int {
        return 3
    }
    
    func saveCategory() {
        let newCategory = Category(
            imageData: self.image?.jpegData(compressionQuality: 1),
            name: self.title,
            sizes: self.sizes
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
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        switch section {
        case SectionType.image.rawValue:
            return 1
        case SectionType.title.rawValue:
            return 1
        case SectionType.size.rawValue:
            return self.sizes.count + 1
        default:
            return 0
        }
    }
    
    func getTitleHeader(for section: Int) -> String {
        switch section {
        case 0:
            return "Imagén"
        case 1:
            return "Título"
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
    
    func getSelectedImage() -> UIImage? {
        return self.image
    }
    
    func setSelectedImage(image: UIImage) {
        self.image = image
    }
    
    func getTitle(index: IndexPath) -> String {
        switch index.section {
        case 1:
            return self.title
        case 2:
            return self.sizes[index.row]
        default:
            return ""
        }
    }
    
    func setTitle(_ title: String, index: IndexPath) {
        switch index.section {
        case 1:
            self.title = title
        case 2:
            self.sizes[index.row] = title
        default: break
        }
    }
    
    func addNewSize() {
        self.sizes.append("")
    }
    
    func setNumeric(index: IndexPath) -> Bool  {
        guard let section = SectionType(rawValue: index.section) else { return  false
        }
        
        switch section {
        case .image:
            _ = false
        case .title:
            _ = false
        case .size:
            _ = false
        }
        return false
    }
}
    
extension AddCategoryViewModel {
    
    private enum SectionType: Int {
        case image = 0
        case title = 1
        case size = 2
    }
}
    
    //
    //    func getNewIndexPathForSizeSection() -> [IndexPath] {
    //
    //      let indexPath =  [
    //        IndexPath(
    //            row: self.sizes.count - 1,
    //            section: SectionType.size.rawValue
    //        )
    //      ]
    //        return indexPath
    //    }
    
