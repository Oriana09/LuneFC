//
//  NameCategoryTableViewCell.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 16/04/2024.
//
import UIKit
import Foundation

protocol NameCategoryTableViewCellDelegate: AnyObject {
    func onTitleChange(_ title: String, cell: UITableViewCell)
    
}
private extension UIConfigurationStateCustomKey {
    static let isNumerico = UIConfigurationStateCustomKey("isNumerico")
}
private extension UICellConfigurationState {
    var isNumerico: Bool? {
        get { return self[.isNumerico] as? Bool }
        set { self[.isNumerico] = newValue }
    }
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
        textField.textColor = ColorManager.light_neutral_1000_dark_neutral_1000
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    weak var delegate: NameCategoryTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        self.contentView.addSubview(self.textField)
        
        NSLayoutConstraint.activate([
            self.textField.leadingAnchor.constraint(
                equalTo: self.contentView.leadingAnchor,
                constant: 16
            ),
            self.textField.trailingAnchor.constraint(
                equalTo: self.contentView.trailingAnchor,
                constant: -16
            ),
            self.textField.topAnchor.constraint(
                equalTo: self.contentView.topAnchor,
                constant: 8
            ),
            self.textField.bottomAnchor.constraint(
                equalTo: self.contentView.bottomAnchor,
                constant: -8
            )
        ])
    }
    
    override var configurationState: UICellConfigurationState {
        var state = super.configurationState
        state.textFieldPlaceholder = self.textField.placeholder
        state.isNumerico = self.textField.keyboardType == .numberPad
        return state
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        
        super.updateConfiguration(using: state)
        
        guard let textFieldPlaceholder = state.textFieldPlaceholder else{
            return
        }
        
        self.textField.placeholder = textFieldPlaceholder
        
        if let isNumerico = state.isNumerico {
            self.textField.keyboardType = isNumerico ? .numberPad : .default
        }
    }
    
    func configure(title: String, placeholder: String, isNumerico: Bool) {
        self.textField.text = title
        self.textField.placeholder = placeholder
        self.textField.keyboardType = isNumerico ? .numberPad : .default
    }
}

//MARK: - UITextFieldDelegate

extension NameCategoryTableViewCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = string.isEmpty && textField.text?.count == 1  ? "" : (textField.text ?? "") + string
        
        self.delegate?.onTitleChange(text, cell: self)
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
           return true
    }
    
}
