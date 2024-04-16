//
//  NameCategoryTableViewCell.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 16/04/2024.
//
import UIKit
import Foundation

protocol NameCategoryTableViewCellDelegate: AnyObject {
    func onTitleChange(_ title: String)
}

private extension UIConfigurationStateCustomKey {
    static let textFieldPlaceholder = UIConfigurationStateCustomKey("textFieldPlaceholder")
}

private extension UICellConfigurationState {
    var textFieldPlaceholder: String? {
        get { return self[.textFieldPlaceholder] as? String }
        set { self[.textFieldPlaceholder] = newValue }
    }
}

class NameCategoryTableViewCell: UITableViewCell {
    
    static let identifier = "NameCategoryTableViewCell"
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "introduce el nombre de categoria"
        textField.textColor = ColorManager.light_neutral_1000_dark_neutral_1000
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    weak var delegate: NameCategoryTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var configurationState: UICellConfigurationState {
        var state = super.configurationState
        
        state.textFieldPlaceholder = self.textField.placeholder
        return state
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        
        super.updateConfiguration(using: state)
        
        guard let textFieldPlaceholder = state.textFieldPlaceholder else{
            return
        }
        
        self.textField.placeholder = textFieldPlaceholder
    }
    
    func configure(title: String) {
        self.textField.text = title
    }
}

extension NameCategoryTableViewCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        self.delegate?.onTitleChange(textField.text ?? "")
        
        return true
    }
}
