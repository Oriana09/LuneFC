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
  
    
   private var viewModel: ClothingListViewModel
    private var filteredItems: [ClothingItem] = []
   private var searchController: UISearchController!
    
    init(viewModel: ClothingListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Lista de Inventario"
        self.setupSearchController()
        self.setupConstrains()
        self.configuteButtom()
        self.viewModel.loadItems()
    }
    
    private func setupSearchController() {
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Buscar por nombre o código"
        self.navigationItem.searchController = searchController
          definesPresentationContext = true
      }
      
    private func setupConstrains() {
        self.view.addSubview(self.tableView)
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(
                equalTo: self.view.topAnchor
            ),
            self.tableView.bottomAnchor.constraint(
                equalTo: self.view.bottomAnchor
            ),
            self.tableView.leadingAnchor.constraint(
                equalTo:  self.view.leadingAnchor
            ),
            self.tableView.trailingAnchor.constraint(
                equalTo: self.view.trailingAnchor
            )
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
        let addClothingListVM = NewClothingItemViewModel(
            category: self.viewModel.category
        )
        let addClothingListVC = NewClothingItemViewController(
            ViewModel: addClothingListVM
        )
        addClothingListVC.delegate = self
        let navigationVC = UINavigationController(
            rootViewController: addClothingListVC
        )
        self.present(navigationVC, animated: true)
    }
    private func updateCategories() {
        self.viewModel.loadItems()
        self.tableView.reloadData()
    }
}
// MARK: - UITableViewDataSource Methods

extension ClothingListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
                return filteredItems.count // Mostrar la cantidad de elementos filtrados
            }
        return self.viewModel.items?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ClothingTableViewCell.identifier, for: indexPath) as! ClothingTableViewCell
        
        guard let items = self.viewModel.items else {
            return UITableViewCell()
        }
        
        let item: ClothingItem
        if isFiltering() {
             item = filteredItems[indexPath.row] // Usar el elemento filtrado
         } else {
             item = items[indexPath.row] // Usar el elemento original
         }
         
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
        
        
            let deleteAction = UIContextualAction(style: .destructive, title: "") { [weak self] (action, view, completionHandler) in
                
                let alertController = UIAlertController(
                    title: "Confirmar eliminación",
                    message: "¿Deseas eliminar este producto de la lista de inventario?",
                    preferredStyle: .alert
                )
                
                let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { _ in
                    completionHandler(false) // No eliminar, ya que canceló
                }
                
                let confirmAction = UIAlertAction(title: "Eliminar", style: .destructive) { _ in
                    guard let itemToRemove = self?.viewModel.items?[indexPath.row] else {
                        completionHandler(false)
                        return
                    }
                    self?.viewModel.deleteClothinList(itemToRemove)
                    tableView.reloadData()
                    completionHandler(true) // Confirmar la eliminación
                }
                
                alertController.addAction(cancelAction)
                alertController.addAction(confirmAction)
                
                self?.present(alertController, animated: true, completion: nil)
            }
            
            deleteAction.image = UIImage(systemName: "trash")
            
            return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension ClothingListViewController: NewClothingItemPresenterDelegate {
    func onDismiss() {
        self.updateCategories()
    }
    
}

extension ClothingListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchText = searchController.searchBar.text else {
            return
        }
        self.filterContentForSearchText(searchText)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        self.filteredItems = self.viewModel.items?.filter { (item: ClothingItem) -> Bool in
            return item.title.lowercased().contains(searchText.lowercased()) ||
            item.idCode.lowercased().contains(searchText.lowercased())
        } ?? []
        
        tableView.reloadData()
    }
    
    private func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    private func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
}
