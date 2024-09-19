//
//  NewClothingItemViewModel.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 08/04/2024.
//

import Foundation
import RealmSwift
import UIKit

class NewClothingItemViewModel {
    
    private let realm = try! Realm()

        
    private var idCode: String {
        didSet {
            self.validateIfCanSaveItems()
        }
    }
    private var title: String {
        didSet {
            self.validateIfCanSaveItems()
        }
    }
    private var price: Double {
        didSet {
            self.validateIfCanSaveItems()
        }
    }
    var items: [ClothingItem] = [] {
        didSet {
            self.validateIfCanSaveItems()
        }
    }
    private var image: UIImage? = UIImage(named: "photo_placeholder")?.withRenderingMode(.alwaysTemplate)
    
    private var size: String
    private var style: String
    
    private var category: Category
    
    
    var onReloadTableView: (() -> Void)?
    var onEnableSaveButton: ((_ isEnable: Bool) -> Void)?
    
    init(
        image: UIImage? = nil,
        idCode: String = "",
        title: String = "",
        price: Double = 0.0,
        size: String = "",
        style:String = "",
        category: Category
    ) {
        self.image = image
        self.idCode = idCode
        self.title = title
        self.price = price
        self.size = size
        self.style = style
        self.category = category
    }
    
    var numberOfSection: Int {
        return 4
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        switch section {
        case SectionType.idCode.rawValue:
            return 1
        case SectionType.title.rawValue:
            return 1
        case SectionType.price.rawValue:
            return 1
        case SectionType.quantity.rawValue:
            
            return self.getItemGroups() + 1
            //            return  self.items.count + 1
            
        default:
            return 0
        }
    }
    
    func getItemGroups() -> Int {
        let groupedItems = Dictionary(grouping: items) {
            ItemKey(size: $0.size, style: $0.style)
        }
        return groupedItems.count
    }
    
    
    func item(for indexPath: IndexPath) -> ClothingItem {
        let groupedItems = Dictionary(grouping: items) {
            ItemKey(size: $0.size, style: $0.style)
        }
        let keys = Array(groupedItems.keys)
        let key = keys[indexPath.row]
        return groupedItems[key]!.first!
    }
    
    func getTitleHeader(for section: Int) -> String {
        switch section {
        case 0:
            return "Código"
        case 1:
            return "Título"
        case 2:
            return "Precio"
        case 3:
            return "Producto"
        default:
            return ""
        }
    }
    
    func getTitleFooter(for section: Int) -> String {
        switch section {
        case 0:
            return ""
        case 1:
            return ""
        case 2:
            return ""
        default:
            return ""
        }
    }
    
    func saveClothingItem() {
        
        self.items.forEach { item in
            do {
                let realm = try Realm()
                try realm.write {
                    realm.add(item)
                }
            } catch {
                print("Error saving category: \(error)")
                fatalError()
            }
        }
    }
    
    func deleteClothinList(_ clothingItem: ClothingItem) {
        try! self.realm.write {
            self.realm.delete(clothingItem)
        }
    }
    
    func getTitle(index: IndexPath) -> String {
        
        guard let section = SectionType(rawValue: index.section) else {
            return ""
        }
        
        switch section {
        case .idCode:
            return self.idCode
        case .title:
            return  self.title
        case .price:
            if self.price == 0.0 {
                return ""
            } else {
                return String(self.price)
            }
          
        case .quantity:
            return self.size
        }
    }
    
    func setTitle(_ title: String, index: IndexPath) {
        
        guard let section = SectionType(rawValue: index.section) else { return }
        
        switch section {
        case .idCode:
            self.idCode = title
        case .title:
            self.title = title
        case .price:
            guard let price = Double(title) else {
                print("Invalid price format: \(title)")
                return
            }
            self.price = price
        case .quantity:
            self.size = title
        }
    }
    
    func setNumeric(index: IndexPath) -> Bool  {
        
        guard let section = SectionType(rawValue: index.section) else { return  false }
        
        switch section {
        case .idCode:
            return false
        case .title:
          return false
        case .price:
          return true
        case .quantity:
            return false
                
        }
       
    }
    func getCategory() -> Category {
        return self.category
    }
    
    func update(for: IndexPath) {
        
    }
    
    func addNewItem(_ item: ClothingItem) {
        self.items.append(item)
    }
    
    func removeItem(_ item: ClothingItem) {
        guard let index = self.items.firstIndex(of: item) else {
            return
        }
        self.items.remove(at: index)
        self.onReloadTableView?()
    }
    
    private func itemsInGroup(at indexPath: IndexPath) -> [ClothingItem] {
        let groupedItems = Dictionary(grouping: items) {
            ItemKey(size: $0.size, style: $0.style)
        }
        let keys = Array(groupedItems.keys)
        let key = keys[indexPath.row]
        return groupedItems[key] ?? []
    }

    func cantOfItemsInGroup(at indexPath: IndexPath) -> Int {
        let itemsInGroup = self.itemsInGroup(at: indexPath)
        return itemsInGroup.count
    }
    
    func validateIfCanSaveItems() {
        let canSaveItems = !self.idCode.isEmpty &&  !self.title.isEmpty && self.price > 0.0 &&  !self.items.isEmpty
        
        self.onEnableSaveButton?(canSaveItems)
    }
}

extension NewClothingItemViewModel {
    
    private enum SectionType: Int {
        case idCode = 0
        case title = 1
        case price = 2
        case quantity = 3
    }
}

extension NewClothingItemViewModel: ProductDetailsViewModelDelegate {
    func addProduct(
        image: UIImage?,
        selectedSize: String,
        selectedStyle: String,
        styles: [String],
        sizes: [String]
    ) {
        
        self.image = image
        self.size = selectedSize
        let item =  ClothingItem(
            image: image?.pngData(),
            idCode: self.idCode,
            title: self.title,
            price: self.price,
            size: selectedSize,
            style:  selectedStyle,
            category: self.category.name
        )
        self.items.append(item)
        //comunicar al viewController que agregue una nueva celda
        self.onReloadTableView?()
    }
}

private struct ItemKey: Hashable {
    let size: String
    let style: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(size)
        hasher.combine(style ?? "")
    }
    static func == (lhs: ItemKey, rhs: ItemKey) -> Bool {
        return lhs.size == rhs.size && lhs.style == rhs.style
    }
}
