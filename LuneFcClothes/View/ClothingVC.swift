//
//  ViewController.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 08/02/2024.
//

import UIKit

class ClothingVC: UIViewController {
    
    var viewModel = ClothingItemViewModel()
    
    private let collection: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createTwoColumnFlowLayout())
        collectionView.register(ClothesCell.self, forCellWithReuseIdentifier: ClothesCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints =  false
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationItem.title = "FC~LUNE"
        self.collection.delegate = self
        self.collection.dataSource = self
        viewModel = ClothingItemViewModel()
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
 
extension ClothingVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.clothingItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClothesCell.identifier, for: indexPath) as! ClothesCell
        
        let clothingItem = viewModel.clothingItems[indexPath.row]
        cell.configure(model: clothingItem )
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           let viewController = ClothingList() // Inicializa el ViewController de la tabla
           navigationController?.pushViewController(viewController, animated: true) // Navega a la tabla
       }
    
}
