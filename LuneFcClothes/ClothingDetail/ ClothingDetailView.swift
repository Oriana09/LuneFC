//
//   ClothingDetailView.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 30/08/2024.
//

import SwiftUI
import RealmSwift

struct ClothingDetailView: View {
    @StateObject var viewModel: ClothingDetailViewModel
    
    var body: some View {
        Form {
            Section {
                TopClothingDetailView(product: self.viewModel.clothingItem)
            }
            Section("Talles disponibles:") {
                Picker("Select a size", selection: $viewModel.selectedSize) {
                    ForEach(viewModel.uniqueSizes() , id: \.self) { size in
                        Text(size)
                        
                    }
                }
                .pickerStyle(.segmented)
                Section("Estilos disponibles:") {
                    Picker("Select a style", selection: $viewModel.selectedStyle) {
                        ForEach(viewModel.uniqueStyles(), id: \.self) { style in
                            Text(style)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .onAppear {
                viewModel.fetchFilteredItems()
            }
//            .onChange(of: viewModel.selectedSize) { _ in
//                viewModel.fetchFilteredItems()
//            }
//            .onChange(of: viewModel.selectedStyle) { _ in
//                viewModel.fetchFilteredItems()
//            }
        }
    
        
    }
    
    init(clothingItem: ClothingItem) {
        let viewModel = ClothingDetailViewModel(clothingItem: clothingItem)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
}


struct ClothingDetailView_Previews: PreviewProvider{
    static var previews: some View {
        NavigationStack {
            ClothingDetailView(clothingItem: ClothingItem.example)
        }
    }
    
}
