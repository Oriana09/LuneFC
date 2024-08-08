//
//  AddProductItem.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 21/05/2024.
//

import Foundation
import UIKit

enum ProductAttributeType {
    case style
    case size
}

class AddProductItemViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(
            frame: .zero
           // style: .grouped
        )
        tableView.delegate = self
        tableView.dataSource = self
       tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Listo", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let viewModel: AddProductItemViewModel
    
    init(viewModel: AddProductItemViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
    }
    
    private func setUI() {
        self.navigationItem.title = "Nuevo Producto"
        self.view.backgroundColor =  ColorManager.light_neutral_50_dark_neutral_100
        self.setupConstraints()
        self.registerCell()
    }
    
    private func setupConstraints() {
        self.view.addSubviews(
            self.tableView,
            self.doneButton
        )
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(
                equalTo: self.view.topAnchor
            ),
            self.tableView.bottomAnchor.constraint(
                equalTo: self.view.bottomAnchor
            ),
            self.tableView.leadingAnchor.constraint(
                equalTo: self.view.leadingAnchor
            ),
            self.tableView.trailingAnchor.constraint(
                equalTo: self.view.trailingAnchor
            ),
            
            self.doneButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            self.doneButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.doneButton.heightAnchor.constraint(equalToConstant: 44),
            self.doneButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func registerCell() {
        self.tableView.register(ImagePickerTableViewCell.self, forCellReuseIdentifier: ImagePickerTableViewCell.identifier)
        self.tableView.register(AddProductCollectionTableViewCell.self, forCellReuseIdentifier: AddProductCollectionTableViewCell.identifier)
    }
    
    @objc private func doneButtonTapped() {
        self.viewModel.saveProducto()
        
        navigationController?.popViewController(animated: true)
    }
    
    func presentAddColorAlert(for type: ProductAttributeType) {
        let title: String
        let placeholder: String
        
        switch type {
        case .style:
            title = "Nuervo Color"
            placeholder = "Color"
        case .size:
            title = "Nuevo Talle"
            placeholder = "Talle"
        }
        
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = placeholder
        }
        let confirmAction = UIAlertAction(title: "OK", style: .default) { _ in
            if let textField = alertController.textFields?.first, let inputText = textField.text {
                switch type {
                case .style:
                    self.viewModel.addStyle(inputText)
                case .size:
                    self.viewModel.addSize(inputText)
                }
                self.tableView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension AddProductItemViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel.getTitleHeader(for: section)
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return self.viewModel.getTitleFooter(for: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell
        
        switch indexPath.section {
        case 0:
            let imageCell = tableView.dequeueReusableCell(
                withIdentifier: ImagePickerTableViewCell.identifier,
                for: indexPath
            ) as! ImagePickerTableViewCell
            imageCell.configure(image: self.viewModel.getSelectedImage())
            cell = imageCell
        case 1:
            let styleCell = tableView.dequeueReusableCell(
                withIdentifier: AddProductCollectionTableViewCell.identifier,
                for: indexPath
            ) as! AddProductCollectionTableViewCell
            styleCell.configure(with: self.viewModel.getStyle(), inputType: .style)
            styleCell.delegate = self
            cell = styleCell
        case 2:
            let sizeCell = tableView.dequeueReusableCell(
                withIdentifier: AddProductCollectionTableViewCell.identifier,
                for: indexPath
            ) as! AddProductCollectionTableViewCell
            sizeCell.configure(
                with: self.viewModel.getSizes(),
                inputType: .size
            )
            sizeCell.delegate = self
            cell = sizeCell
        default:
            cell = UITableViewCell()
        }
        return cell
    }
}


// MARK: - UITableViewDelegate

extension AddProductItemViewController: UITableViewDelegate, UINavigationControllerDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }
    }
}

//MARK: - UIImagePickerControllerDelegate

extension AddProductItemViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedIndexPath = self.tableView.indexPathForSelectedRow else {
            return
        }
        
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        
        guard let cell = self.tableView.cellForRow(at: selectedIndexPath) as? ImagePickerTableViewCell else {
            return
        }
        
        self.viewModel.setSelectedImage(image: image)
        cell.deleteButton.isHidden = false
        
        self.tableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddProductItemViewController: AddProductCollectionTableViewCellDelegate {
    func ButtonDidSeleceted(type: ProductAttributeType, _ title: String) {
        switch type {
        case .style:
            self.viewModel.selectedStyle = title
        case .size:
            self.viewModel.selectedSize = title
        }
    }
   

    func OnAddButtonTap(for type: ProductAttributeType) {
        self.presentAddColorAlert(for: type)
    }
    
    //
    
}
