
//  ClothingDetailViewModel.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 09/09/2024.


import SwiftUI
import RealmSwift

class ClothingDetailViewModel: ObservableObject {
    
   @ObservedResults(ClothingItem.self) var clothingItems
    @Published var selectedSize: String = ""
    @Published var selectedStyle: String = ""
    @Published var selectedImage: UIImage? = nil
//    @Published var filteredItems: [ClothingItem] = []
    @Published var filteredStyles: [String] = []
    @Published var allStyles: [String] = []
    @Published var numberOfItems: Int = 0
    
    var clothingItem: ClothingItem
    
    init(clothingItem: ClothingItem) {
        self.clothingItem = clothingItem
        self.selectedSize = uniqueSizes().first ?? ""
        // Actualizar los estilos al iniciar
        self.updateAllStyles()
        self.updateFilteredStyles()
//        self.updateNumberOfITems()
    }
    
    func updateAllStyles() {
          
        let styles = clothingItems.filter { $0.title == self.clothingItem.title }.compactMap { $0.style }
           allStyles = Array(Set(styles)).sorted()
       }
    
    func updateFilteredStyles() {
      
        let matchingItems = clothingItems.filter {
            $0.size == self.selectedSize &&
            $0.title == self.clothingItem.title
        }
        let matchingStyles = matchingItems.compactMap { $0.style }
        
        self.filteredStyles = Array(Set(matchingStyles)).sorted()
       
        self.selectedStyle = self.filteredStyles.first ?? ""
       
    }
    
    func updateImageForSelectedAttributes() {
        if let matchingItem = clothingItems.first(where: { $0.size == self.selectedSize && $0.title == self.clothingItem.title && $0.style == self.selectedStyle }) {
            if let imageData = matchingItem.image {
                self.selectedImage = UIImage(data: imageData)
            } else {
                self.selectedImage = nil // O una imagen predeterminada si no hay imagen
            }
        }
    }
    func updateNumberOfITems() {
        let matchingItem = clothingItems.filter {
            $0.size.lowercased() == self.selectedSize.lowercased() &&
            $0.title.lowercased() == self.clothingItem.title.lowercased() &&
            $0.style?.lowercased() == self.selectedStyle.lowercased()
        }
        let itemsArray = Array(Set(matchingItem))
//        let matchingItemsArray = Array(matchingItems)
//
//        for item in matchingItemsArray {
//            print("Title: \(item.title), Size: \(item.size), Style: \(item.style)")
//        }
        self.numberOfItems = itemsArray.count
    }
    
    func uniqueSizes() -> [String] {
     
        let sizes = clothingItems.filter {
            $0.title == self.clothingItem.title
        }.map {
            $0.size
        }
        return Array(Set(sizes)).sorted()
    }
    
}

