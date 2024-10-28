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
                TopClothingDetailView(image: self.viewModel.selectedImage, product: self.viewModel.clothingItem)
            }
            Section("Stock: \(viewModel.numberOfItems)")  {
                
                Text("Talles")
                    .font(.headline)
                
                Picker("Select a size", selection: $viewModel.selectedSize) {
                    ForEach(viewModel.uniqueSizes(), id: \.self) { size in
                        Text(size)
                    }
                }
                .pickerStyle(.segmented)
                
                .onChange(of: viewModel.selectedSize) {
                    self.viewModel.updateFilteredStyles()
                    self.viewModel.updateNumberOfITems()
                    self.viewModel.updateImageForSelectedAttributes()
                }
                .listRowInsets(EdgeInsets())
                Text("Estilos")
                    .font(.headline)
                
                // Picker para seleccionar el estilo
                Picker("Select a style", selection: $viewModel.selectedStyle) {
                    ForEach(viewModel.filteredStyles, id: \.self) { style in
                        Text(style)
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: viewModel.selectedStyle) {
                    self.viewModel.updateNumberOfITems()
                    self.viewModel.updateImageForSelectedAttributes()
                }
            }
            .onAppear {
                
                self.viewModel.updateFilteredStyles()
                self.viewModel.updateNumberOfITems()
                viewModel.updateImageForSelectedAttributes() // Actualiza la imagen al aparecer
            }
            
        }
        
    }
    init(
        clothingItem: ClothingItem
    ) {
        let viewModel = ClothingDetailViewModel(
            clothingItem: clothingItem
        )
        _viewModel = StateObject(
            wrappedValue: viewModel
        )
    }
}




struct ClothingDetailView_Previews: PreviewProvider{
    static var previews: some View {
        NavigationStack {
            ClothingDetailView(clothingItem: ClothingItem.example)
        }
    }
    
}
