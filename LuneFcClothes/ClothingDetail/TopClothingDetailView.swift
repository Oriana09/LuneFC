//
//  ImageAndCode.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 02/09/2024.
//

import SwiftUI
import UIKit
struct TopClothingDetailView: View {
    
    let product: ClothingItem
    
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                if let data =  product.image, let uiimage = UIImage(data: data) {
                    Image(uiImage: uiimage)
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 250, maxHeight: 250)
                } else {
                    Text("No image available")
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
            TopClothingDetailView(product: ClothingItem.example )
        }
        
        
    }
}
