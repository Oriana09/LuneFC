//
//  ClothingDetailViewModel.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 09/09/2024.
//

import SwiftUI
import RealmSwift

class ClothingDetailViewModel: ObservableObject {
    
    @ObservedResults(ClothingItem.self) var clothingItems
    @Published var selectedSize: String = ""
    @Published var selectedStyle: String = ""
    @Published var filteredItems: [ClothingItem] = []
    
    var clothingItem: ClothingItem
    
    init(clothingItem: ClothingItem) {
        self.clothingItem = clothingItem
    }
    
    func fetchFilteredItems() {
        
        self.filteredItems = clothingItems.filter { $0.title == clothingItem.title &&
            (self.selectedSize.isEmpty || $0.size == self.selectedSize) &&
            
            (self.selectedStyle.isEmpty || $0.style == self.selectedStyle) }
        
        self.selectedSize = self.filteredItems.first?.size ?? ""
        
        self.selectedStyle = self.filteredItems.first?.style ?? ""
    }
    func uniqueSizes() -> [String] {
        let sizes = filteredItems.map { $0.size }
        return Array(Set(sizes)).sorted()
    }
    
    func uniqueStyles() -> [String] {
        let styles = filteredItems.compactMap { $0.style }
        return Array(Set(styles)).sorted()
    }
    
}

