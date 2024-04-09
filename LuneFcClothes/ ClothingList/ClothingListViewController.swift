//
//  clothingList.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 15/02/2024.
//

import Foundation
import UIKit
import RealmSwift

class ClothingListViewController: UIViewController {
        
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ClothingTableViewCell.self, forCellReuseIdentifier: ClothingTableViewCell.identifier)
        tableView.delegate =  self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    var viewModel: ClothingListViewModel
    
    init(viewModel: ClothingListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Colecciones"
        self.setupConstrains()
        self.configuteButtom()
        self.viewModel.loadItems()
    }
    
    private func setupConstrains() {
        self.view.addSubview(self.tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func configuteButtom(){
        
        let addButton =  UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(addButtonAction(_:))
        )
        addButton.tintColor = ColorManager.light_neutral_1000_dark_neutral_1000
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addButtonAction(_ sender: UIBarButtonItem) {
    let addClothingListVM = AddClothingListViewModel()
    let addClothingListVC = AddClothingListViewController(ViewModel: addClothingListVM)
    }
}
// MARK: - UITableViewDataSource Methods

extension ClothingListViewController: UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.items?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ClothingTableViewCell.identifier, for: indexPath) as! ClothingTableViewCell
        
        guard let items = self.viewModel.items else {
            return UITableViewCell()
        }
        
        let item = items[indexPath.row]
        cell.configure(model: item)
        
        return cell
    }
    
    
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //
    //        let productDetailVC = ProductDetailViewController(viewModel: ProductDatailViewModel(products: self.viewModel.items[indexPath.row]))
    //
    //
    //        let navController = UINavigationController(rootViewController: productDetailVC)
    //
    //        present(navController, animated: true, completion: nil)
    //    }
}

// MARK: -  UITableViewDelegate Methods

extension ClothingListViewController: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Eliminar") { [weak self] (action, view, completionHandler) in
            guard let itemToRemove = self?.viewModel.items?[indexPath.row] else {
                completionHandler(false)
                return
            }
            self?.viewModel.deleteClothinList(itemToRemove)
            completionHandler(true)
            
            tableView.reloadData()
        }
        deleteAction.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}


