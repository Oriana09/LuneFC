//
//  AddProductItem.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 21/05/2024.
//

import Foundation
import UIKit

class AddProductItemViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(
            frame: .zero,
            style: .insetGrouped
        )
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let viewModel: AddProductItemViewModel
//    private var categorySizes: [String] = []
//    private var selectedCategoryName: String
    
    init(viewModel: AddProductItemViewModel) {
        self.viewModel = viewModel
//        self.selectedCategoryName = categoryName
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
//        self.tableView.reloadData()

    }
    
    private func setupConstraints() {
        self.view.addSubview(self.tableView)
        
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
            )
        ])
    }
    
    private func registerCell() {
        self.tableView.register(ImagePickerTableViewCell.self, forCellReuseIdentifier: ImagePickerTableViewCell.identifier)
        self.tableView.register(SizesCollectionTableViewCell.self, forCellReuseIdentifier: SizesCollectionTableViewCell.identifier)
        
    }
    
//    private func loadSizes() {
//        // Utiliza el nombre de la categoría seleccionada para recuperar las tallas
//        viewModel.selectCategory(named: self.selectedCategoryName)
//        self.categorySizes = viewModel.getCategorySizes()
//        self.tableView.reloadData()
//    }

}

// MARK: - UITableViewDataSource

extension AddProductItemViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel.getTitleHeader(section: section)
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
        case 2:
            let sizeCell = tableView.dequeueReusableCell(
                withIdentifier: SizesCollectionTableViewCell.identifier,
                for: indexPath
            ) as! SizesCollectionTableViewCell
            sizeCell.configure(with: self.viewModel.getCategory())
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
