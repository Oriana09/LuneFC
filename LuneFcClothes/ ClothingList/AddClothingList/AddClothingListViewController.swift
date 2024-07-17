//
//  AddClothingListViewController.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 08/04/2024.
//

import UIKit

protocol AddClothingListPresenterDelegate: AnyObject {
    func onDismiss()
}
class AddClothingListViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(
            frame: .zero,
            style: .insetGrouped
        )
        tableView.delegate =  self
        tableView.dataSource = self
        tableView.register(ImagePickerTableViewCell.self, forCellReuseIdentifier: ImagePickerTableViewCell.identifier)
        tableView.register(NameCategoryTableViewCell.self, forCellReuseIdentifier: NameCategoryTableViewCell.identifier)
        tableView.register(AddSizeButtonTableViewCell.self, forCellReuseIdentifier: AddSizeButtonTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let viewModel: AddClothingListViewModel
    weak var delegate: AddClothingListPresenterDelegate?
    
    init(ViewModel: AddClothingListViewModel) {
        self.viewModel = ViewModel
        super.init(nibName: nil, bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SetUI()
        self.configureViewModel()
    }
    
    private func configureViewModel() {
        self.viewModel.onReloadTableView = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    private func SetUI() {
        self.navigationItem.title = "Nuevo Producto"
        self.view.backgroundColor =  ColorManager.light_neutral_50_dark_neutral_100
        self.setupConstraints()
        self.createCancelButton()
        self.saveClothingButton()
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
    
    private func saveClothingButton(){
        
        let addCategoryButton =  UIBarButtonItem(
            title: "Agregar",
            style: .plain,
            target: self,
            action: #selector(addClothing)
        )
        
        addCategoryButton.tintColor = ColorManager.button_primary_blue_light_button_prmary_blue_dark
        navigationItem.rightBarButtonItem = addCategoryButton
    }
    
    @objc private func addClothing() {
        //self.ViewModel.SaveClothing
        self.dismissAction()
    }
    
    private func dismissAction() {
        self.delegate?.onDismiss()
        self.dismiss(animated: true, completion: nil)
    }
    
}


//MARK: - UITableViewDataSourc
extension AddClothingListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel.getTitleHeader(for: section)
    }
    
    //    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    //        return self.ViewModel.getTitleFooter(for: section)
    //    }
    
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
            let idCodeCell = tableView.dequeueReusableCell(
                withIdentifier: NameCategoryTableViewCell.identifier,
                for: indexPath
            ) as! NameCategoryTableViewCell
            idCodeCell.configure(
                title: self.viewModel.getTitle(index: indexPath), placeholder: "Ej:AR24094"
            )
            idCodeCell.delegate = self
            cell = idCodeCell
            
        case 1:
            let titleCell = tableView.dequeueReusableCell(
                withIdentifier: NameCategoryTableViewCell.identifier,
                for: indexPath
            ) as! NameCategoryTableViewCell
            
            titleCell.configure(
                title: self.viewModel.getTitle(index: indexPath), placeholder: "Ej:Pantalón Wid Leg"
            )
            titleCell.delegate = self
            cell = titleCell
            
        case 2:
            let priceCell = tableView.dequeueReusableCell(
                withIdentifier: NameCategoryTableViewCell.identifier,
                for: indexPath
            ) as! NameCategoryTableViewCell
            
            priceCell.configure(
                title: self.viewModel.getTitle(index: indexPath), placeholder: "$"
            )
            priceCell.delegate = self
            cell = priceCell
        case 3:
            if indexPath.row == self.viewModel.items.count {
                let addSize = tableView.dequeueReusableCell(
                    withIdentifier: AddSizeButtonTableViewCell.identifier, for: indexPath
                ) as! AddSizeButtonTableViewCell
                addSize.delegate = self
                cell = addSize
            } else {
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: AddProductTableViewCell.identifier,
                    for: indexPath
                ) as! AddProductTableViewCell
                let item = viewModel.items[indexPath.row]
                cell.configure(with: item)
                return cell
            }
            
            //            let imageCell = tableView.dequeueReusableCell(
            //                withIdentifier: ImagePickerTableViewCell.identifier,
            //                for: indexPath
            //            ) as! ImagePickerTableViewCell
            //            imageCell.configure(image: self.ViewModel.getSelectedImage())
            //            cell = imageCell
            //        case 1:
            //            let idCodeCell = tableView.dequeueReusableCell(
            //                withIdentifier: NameCategoryTableViewCell.identifier,
            //                for: indexPath
            //            ) as! NameCategoryTableViewCell
            //            idCodeCell.configure(
            //                title: self.ViewModel.getTitle(index: indexPath), placeholder: ""
            //            )
            //            idCodeCell.delegate = self
            //
            //            cell = idCodeCell
            //
            //
            
        default:
            cell = UITableViewCell()
        }
        return cell
    }
}

//MARK: - UITableViewDelagate
extension AddClothingListViewController: UITableViewDelegate, UINavigationControllerDelegate {
    
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

extension AddClothingListViewController: UIImagePickerControllerDelegate {
    
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

extension AddClothingListViewController: NameCategoryTableViewCellDelegate {
    
    func onTitleChange(_ title: String, cell: UITableViewCell) {
        guard let index = self.tableView.indexPath(for: cell) else {
            return
        }
        
        self.viewModel.setTitle(title, index: index)
    }
}

//MARK: - AddSizeButtonTableViewCellDelegate

extension AddClothingListViewController: AddSizeButtonTableViewCellDelegate {
    func didTapAddSizeButton() {
        let addProdudctVM = AddProductItemViewModel(
            delegate: self.viewModel,
            sizes: self.viewModel.getCategory().stringSizes
        )
        let addProductVC = AddProductItemViewController(
            viewModel: addProdudctVM)
        
        self.navigationController?.pushViewController(
            addProductVC,
            animated: true
        )
    }
}
