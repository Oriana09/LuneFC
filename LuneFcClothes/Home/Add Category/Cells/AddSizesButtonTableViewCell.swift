//
//  AddSizeTableViewCell.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 10/04/2024.
//

import Foundation
import UIKit

protocol AddSizeButtonTableViewCellDelegate: AnyObject {
    func didTapAddSizeButton()
}

private extension UIConfigurationStateCustomKey {
    static let imageCenter = UIConfigurationStateCustomKey("imageCenter")
}

private extension UICellConfigurationState {
    var imageCenter: UIImage? {
        get { return self[.imageCenter] as? UIImage }
        set { self[.imageCenter] = newValue }
    }
}
class AddSizeButtonTableViewCell: UITableViewCell {
    
    static let identifier = "AddSizeButtonTableViewCell"
    
    weak var delegate: AddSizeButtonTableViewCellDelegate?
    
    private  lazy var plusImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "plus")
        imageView.tintColor = ColorManager.button_primary_blue_light_button_prmary_blue_dark
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.set()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func set() {
        self.contentView.addSubview(self.plusImage)
        
        NSLayoutConstraint.activate([
            self.plusImage.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.plusImage.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }
    
    
    override var configurationState: UICellConfigurationState {
        var state = super.configurationState
        state.imageCenter = self.plusImage.image
        return state
    }
    
    override func updateConfiguration(using state:UICellConfigurationState) {
        super.updateConfiguration(using: state)
        
        self.plusImage.image = state.imageCenter
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        self.contentView.addGestureRecognizer(tapGesture)
        
        self.isUserInteractionEnabled = true
        
    }
    
    @objc func handleTapGesture(_ sender: UITapGestureRecognizer) {
        
        self.delegate?.didTapAddSizeButton()
    }
}

