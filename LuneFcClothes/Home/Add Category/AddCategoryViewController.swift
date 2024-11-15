//
//  AddCategoryViewController.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 11/03/2024.

import Foundation
import UIKit

protocol AddCategoryPresenterDelegate: AnyObject {
    func onDismiss()
}

class AddCategoryViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(
            frame: .zero,
            style: .insetGrouped
        )
        tableView.delegate =  self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let viewModel: AddCategoryViewModel
    weak var delegate: AddCategoryPresenterDelegate?
    
    init(viewModel: AddCategoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.registerCells()
    }
    
    private func setUI() {
        self.navigationItem.title = "Nueva Categoría"
        self.view.backgroundColor =  ColorManager.light_neutral_50_dark_neutral_100
        self.setupConstraints()
        self.createCancelButton()
        self.saveCategoryButton()
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
    
    private func registerCells() {
        self.tableView.register(ImagePickerTableViewCell.self, forCellReuseIdentifier: ImagePickerTableViewCell.identifier)
        self.tableView.register(NameCategoryTableViewCell.self, forCellReuseIdentifier: NameCategoryTableViewCell.identifier)
        self.tableView.register(AddSizeButtonTableViewCell.self,
                                forCellReuseIdentifier: AddSizeButtonTableViewCell.identifier )
    }
    
    private func createCancelButton(){
        
        let addButton =  UIBarButtonItem(
            title: "Cancelar",
            style: .plain,
            target: self,
            action: #selector(cancelAction)
        )
        addButton.tintColor = ColorManager.button_primary_blue_light_button_prmary_blue_dark
        navigationItem.leftBarButtonItem = addButton
    }
    
    @objc func cancelAction() {
        self.cancelAlert()
    }
    
    private func cancelAlert() {
        let alert = UIAlertController(
            title: "¿Estás seguro que desea salir?",
            message: nil,
            preferredStyle: .alert
        )
        
        alert.addAction(
            UIAlertAction(
                title: "Sí",
                style: .default,
                handler: { _ in
                    
                    self.dismissAction()
                }))
        
        alert.addAction(
            UIAlertAction(
                title: "Cancelar",
                style: .cancel,
                handler: nil
            )
        )
        
        self.present(
            alert,
            animated: true,
            completion: nil
        )
    }
    
    private func saveCategoryButton(){
        
        let addCategoryButton =  UIBarButtonItem(
            title: "Agregar",
            style: .plain,
            target: self,
            action: #selector(addCategory)
        )
        
        addCategoryButton.tintColor = ColorManager.button_primary_blue_light_button_prmary_blue_dark
        navigationItem.rightBarButtonItem = addCategoryButton
    }
    
    @objc private func addCategory() {
        self.viewModel.saveCategory()
        self.dismissAction()
    }
    
    private func dismissAction() {
        self.delegate?.onDismiss()
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension AddCategoryViewController: UITableViewDataSource {
    
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
            let nameCell = tableView.dequeueReusableCell(
                withIdentifier: NameCategoryTableViewCell.identifier,
                for: indexPath
            ) as! NameCategoryTableViewCell
            nameCell.configure(
                title: self.viewModel.getTitle(
                    index: indexPath
                ), placeholder: "Remeras", isNumerico: self.viewModel.setNumeric(index: indexPath)
            )
            nameCell.delegate = self
            
            cell = nameCell
            
        case 2:
            if indexPath.row == self.viewModel.numberOfRowsInSection(indexPath.section) - 1 {
                let addSize = tableView.dequeueReusableCell(
                    withIdentifier: AddSizeButtonTableViewCell.identifier, for: indexPath
                ) as! AddSizeButtonTableViewCell
                addSize.delegate = self
                cell = addSize
                
            } else {
                let ziseCell = tableView.dequeueReusableCell(
                    withIdentifier: NameCategoryTableViewCell.identifier,
                    for: indexPath
                ) as! NameCategoryTableViewCell
                
                ziseCell.configure(
                    title: self.viewModel.getTitle(
                        index: indexPath
                    ), placeholder: "S", isNumerico: self.viewModel.setNumeric(index: indexPath)
                )
                ziseCell.delegate = self
                cell = ziseCell
            }
            
        default:
            cell = UITableViewCell()
        }
        
        return cell
    }
}

//MARK: - UITableViewDelegate - UINavigationControllerDelegate

extension AddCategoryViewController: UITableViewDelegate, UINavigationControllerDelegate {
    
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

extension AddCategoryViewController: UIImagePickerControllerDelegate {
    
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

//MARK: - NameCategoryTableViewCellDelegate

extension AddCategoryViewController: NameCategoryTableViewCellDelegate {
    
    func onTitleChange(_ title: String, cell: UITableViewCell) {
        guard let index = self.tableView.indexPath(for: cell) else {
            return
        }
        self.viewModel.setTitle(title, index: index)
    }
}

//MARK: - AddSizeButtonTableViewCellDelegate

extension AddCategoryViewController: AddSizeButtonTableViewCellDelegate {
    
    func didTapAddSizeButton() {
        
        let lastIndex = viewModel.sizes.count - 1
        
        if !viewModel.sizes[lastIndex].isEmpty {
            self.viewModel.addNewSize()
            
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [IndexPath(row: lastIndex + 1, section: 2)], with: .automatic)
            self.tableView.endUpdates()
            
            self.tableView.scrollToRow(at: IndexPath(row: lastIndex + 1, section: 2), at: .bottom, animated: true)
            
        }
    }
}
