//
//  clothingList.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 15/02/2024.
//

import Foundation
import UIKit

class ClothingList: UIViewController {
 
    var viewModel = ClothingItemViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ClothingListCell.self, forCellReuseIdentifier: ClothingListCell.identifier)
        tableView.delegate =  self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Colecciones"
        self.setupConstrains()
        viewModel = ClothingItemViewModel()
        self.configuteButtom()
      
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
      
    }
}
    // MARK: - UITableViewDataSource Methods UITableViewDelegate Methods
    
    extension ClothingList: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              return viewModel.clothingItems.count // Número de filas que deseas mostrar
          }
      
          func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              
              let cell = tableView.dequeueReusableCell(withIdentifier: ClothingListCell.identifier, for: indexPath) as! ClothingListCell
             
              let clothingItem = viewModel.clothingItems[indexPath.row]
              cell.configure(model: clothingItem )
//
//              cell.textLabel?.text = labelText
//              cell.imageView?.image = UIImage(named: imageName)
      
              return cell
          }

//         
//          func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//              print("Seleccionaste la fila \(indexPath.row)")
//          }
          
    }
//
//
    





