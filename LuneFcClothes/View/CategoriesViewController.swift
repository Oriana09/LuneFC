//
//  ViewController.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 08/02/2024.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    
    private let collection: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createTwoColumnFlowLayout())
        collectionView.register(ClothesCell.self, forCellWithReuseIdentifier: ClothesCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints =  false
        return collectionView
    }()
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationItem.title = "FC~LUNE"
        self.collection.delegate = self
        self.collection.dataSource = self
        self.configuteButtom()
        self.setContrains()
        
        let backButton = UIBarButtonItem()
               backButton.title = ""
               self.navigationItem.backBarButtonItem = backButton
        
    }
    
    private func setContrains() {
        self.view.addSubview(self.collection)
        
        NSLayoutConstraint.activate([
           self.collection.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
           self.collection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
           self.collection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
}
// MARK: - UITableViewDataSource  UITableViewDelegate 
 
extension CategoriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClothesCell.identifier, for: indexPath) as! ClothesCell
        
        let category = categories[indexPath.row]
        cell.configure(model: category)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let categoriaSeleccionada = categories[indexPath.row]
        
        let prendesFiltradas = clothingItems.filter { $0.category == categoriaSeleccionada.name }
        
        let listaPrendasViewController = ClothingListViewController(
            viewModel: ClothingListViewModel(
                items: prendesFiltradas
            )
        )
       
        
       
        navigationController?.pushViewController(listaPrendasViewController, animated: true)
    }
}
