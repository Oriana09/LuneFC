//
//  CustumTableViewCell.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 13/04/2024.
//

import Foundation
import UIKit


class ImagePickerTableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"
    
    var image: UIImage?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
    
        var contentConfig = defaultContentConfiguration()
        contentConfig.image = self.image
        contentConfig.imageProperties.tintColor = ColorManager.light_neutral_1000_dark_neutral_1000
       
        let cellWidth = self.contentView.frame.width - 32
        let customSize = CGSize(
            width: cellWidth,
            height: 200
        )
        contentConfig.imageProperties.reservedLayoutSize = customSize
        contentConfiguration = contentConfig
        
    }
    
    func configure(image: UIImage?) {
        self.image = image
    }
}
