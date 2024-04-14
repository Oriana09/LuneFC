//
//  AddCategoryViewController.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 11/03/2024.
//

import Foundation
import UIKit

protocol AddCategoryPresenterDelegate: AnyObject {
    func onDismiss()
}

class AddCategoryViewController: UIViewController, UINavigationControllerDelegate {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(
            frame: .zero,
            style: .insetGrouped
        )
        tableView.delegate =  self
        tableView.dataSource = self
        tableView.register(ImagePickerTableViewCell.self, forCellReuseIdentifier: ImagePickerTableViewCell.identifier)
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
        self.SetUI()
    }
    
    private func SetUI() {
        self.navigationItem.title = "Nueva Categoria"
        self.view.backgroundColor =  ColorManager.light_neutral_50_dark_neutral_100
        self.setupConstrains()
        self.cancelButton()
        self.addCategoryButton()
    }
    
    private func setupConstrains() {
        self.view.addSubview(self.tableView)
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(
                equalTo: view.topAnchor
            ),
            self.tableView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),
            self.tableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            self.tableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            )
        ])
    }
    
    private func cancelButtom(){
        
        let addButton =  UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(cancelButton)
        )
        addButton.tintColor = ColorManager.button_primary_blue_light_button_prmary_blue_dark
        navigationItem.leftBarButtonItem = addButton
    }
    
    @objc func cancelButton() {
        self.confirmationAlert()
    }
    
    private func confirmationAlert() {
        let alert = UIAlertController(title: "¿Estás segura?", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Sí", style: .default, handler: { _ in
            
            self.dismiss()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    private func addCategoryButton(){
        
        let addCategoryButton =  UIBarButtonItem(
            title: "Agregar",
            style: .plain,
            target: self,
            action: #selector(addCategory)
        )
        
        addCategoryButton.tintColor = ColorManager.button_primary_blue_light_button_prmary_blue_dark
        navigationItem.rightBarButtonItem = addCategoryButton
    }
#warning("una vez que selecciono el boton quiero que se me agregue a categoryViewController")
    @objc private func addCategory() {
        self.viewModel.saveCategory()
        self.dismiss()
    }
    
    private func dismiss() {
        self.delegate?.onDismiss()
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension AddCategoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel.getTitle(for: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        #warning("Get from viewModel")
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        #warning("Get from viewModel")
        return 1
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
        default:
            cell = tableView.dequeueReusableCell(
                withIdentifier: ImagePickerTableViewCell.identifier,
                for: indexPath
            ) as! ImagePickerTableViewCell
        }
        
        return cell
    }
}



//MARK: - UITableViewDelegate

extension AddCategoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
                  // Abre la galería de imágenes del dispositivo
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
        self.tableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
}
