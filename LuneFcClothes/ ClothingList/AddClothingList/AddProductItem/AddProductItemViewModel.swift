//
//  AddProductItemViewModel.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 23/05/2024.
//

import Foundation
import RealmSwift
import UIKit

protocol AddProductItemViewModelDelegate: AnyObject {
    func addProduct(
        image: UIImage?,
        selectedSize: String,
        selectedStyle: String,
        styles: [String],
        sizes: [String]
    )
}

class AddProductItemViewModel {
    
    private let realm = try! Realm()
    weak var delegate: AddProductItemViewModelDelegate?
    
    private var image: UIImage? = UIImage(
        named: "photo_placeholder"
    )?.withRenderingMode(.alwaysTemplate)
    var selectedSize: String
    var selectedStyle: String
    var styles: [String]
    var sizes: [String]
    
    
    init(
        delegate: AddProductItemViewModelDelegate?,
        image: UIImage? = nil,
        selectedSize: String = "",
        selectedStyle: String = "",
        styles: [String] = [],
        sizes: [String] 
    ) {
        self.delegate = delegate
        self.image = image
        self.selectedSize = selectedSize
        self.selectedStyle = selectedStyle
        self.styles = styles
        self.sizes = sizes
    }
    
    var numberOfSection: Int {
        return 3
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        switch section {
        case SectionType.image.rawValue:
            return 1
        case SectionType.size.rawValue:
            return 1
        case SectionType.style.rawValue:
            return 1
        default:
            return 0
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
    
    func getSizes() -> [String] {
        return self.sizes
    }
    
    func getStyle() -> [String] {
        return self.styles
    }
    
    func addStyle(_ style: String) {
        self.styles.append(style)
    }
    
    func addSize(_ size: String) {
        self.sizes.append(size)
    }
    
    func saveProducto() {
        self.delegate?.addProduct(
            image: self.image,
            selectedSize: self.selectedSize,
            selectedStyle: self.selectedStyle,
            styles: self.styles,
            sizes: self.sizes
        )
    }
}

extension AddProductItemViewModel {
    
    private enum SectionType: Int {
        case image = 0
        case size = 1
        case style = 2
    }
}

