//
//  StyleAndSizeView.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 10/09/2024.
//

import SwiftUI
import RealmSwift

struct StyleAndSizeView: View {

    
    let products: [ClothingItem]
    
    var body: some View {
        
        VStack {
            Text("Talles disponibles")
                .font(.headline)
            
            HStack {
                // Filtrar los talles únicos para evitar duplicados
                ForEach(products, id:\.self) { product in
                    Text(product.size)
                }
            }
        }
    }
   
}

struct StyleAndSize_Previews: PreviewProvider {
    static var previews: some View {
        StyleAndSizeView(
            products: [
                ClothingItem.example,
                ClothingItem.example,
                ClothingItem.example,
                ClothingItem.example
            ]
        )
    }
}


