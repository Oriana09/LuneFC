//
//  ViewController.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 08/02/2024.
//

import UIKit

#warning("contextualmeniu sobre una UICollection")
class CategoryViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UIHelper.createTwoColumnFlowLayout()
        )
        collectionView.register(
            CategoryCell.self,
            forCellWithReuseIdentifier: CategoryCell.identifier
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private let viewModel: CategoryViewModel
    
    init(
        viewModel: CategoryViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateCategories()
        self.navigationItem.title = "FC~LUNE"
        self.configuteButtom()
        self.setCollectionContraints()
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationItem.backBarButtonItem = backButton
        
    }
    
    private func configuteButtom() {
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
        let viewModel = AddCategoryViewModel()
        let addCategoryVC = AddCategoryViewController(
            viewModel: viewModel
        )
        addCategoryVC.delegate = self
        let navigationVC = UINavigationController(
            rootViewController: addCategoryVC
        )
        
        self.present(navigationVC, animated: true)
    }
    
    private func updateCategories() {
        self.viewModel.loadCategories()
        self.collectionView.reloadData()
    }
    
    private func setCollectionContraints() {
        self.view.addSubview(self.collectionView)
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.topAnchor
            ),
            self.collectionView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),
            self.collectionView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            self.collectionView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
            )
        ])
    }
}

// MARK: - UICollectionViewDataSource

extension CategoryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.categories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
        
        
        guard let categories = self.viewModel.categories else {
            return UICollectionViewCell()
        }
        
        let category = categories[indexPath.row]
        cell.configure(model: category)
        
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension CategoryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let selectedCategory = viewModel.categories?[indexPath.row] else {
            // Si no hay una categoría existente retornamos
            return
        }
        
//        self.viewModel.deleteCategory(selectedCategory)
//        self.collectionView.reloadData()
        let clothingListVM = ClothingListViewModel(category: selectedCategory)
        let clothingListVC = ClothingListViewController(
            viewModel: clothingListVM
        )
        
        self.navigationController?.pushViewController(clothingListVC, animated: true)
    }
}

//MARK: - AddCategoryPresenterDelegate

extension CategoryViewController: AddCategoryPresenterDelegate {
    
    func onDismiss() {
        self.updateCategories()
    }
}


