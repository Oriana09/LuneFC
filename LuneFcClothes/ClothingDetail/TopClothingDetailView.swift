//
//  ImageAndCode.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 02/09/2024.
//

import SwiftUI
import UIKit
struct TopClothingDetailView: View {
    
    var image: UIImage?
    let product: ClothingItem
    //        .resizable()
    //        .scaledToFit()
    
    var body: some View {
        VStack() {
            ZStack(alignment: .bottomTrailing) {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                } else {
                    
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                }
                Text("Codigo:\(product.idCode)")
                    .padding(4)
                    .background(.black)
                    .font(.caption)
                    .foregroundColor(.white)
                    .offset(x: -5, y: -5)
                
            }
        }
        .navigationTitle(product.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ImageAndCode_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TopClothingDetailView( product: ClothingItem.example)
        }
        
        
    }
}


