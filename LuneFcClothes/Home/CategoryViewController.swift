//
//  ViewController.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 08/02/2024.
//

import UIKit

class CategoryViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UIHelper.createTwoColumnFlowLayout()
        )
        collectionView.register(
            CategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier
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
        self.configureNavigationBar()
        self.view.backgroundColor = ColorManager.light_neutral_50_dark_neutral_100
        self.updateCategories()
        self.setCollectionContraints()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "FC~LUNE"
        self.navigationController?.navigationBar.isHidden = false
        self.navigationButtom()
        self.configuteButtom()
    }
    
    private func navigationButtom() {
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
        addButton.tintColor = ColorManager.button_primary_blue_light_button_prmary_blue_dark
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
        
        
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
            
            return
        }
        let clothingListVM = ClothingListViewModel(
            category: selectedCategory
        )
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

//MARK: - UICollectionViewDelegateFlowLayout

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        guard let selectedCategory = viewModel.categories?[indexPath.row] else {
            return nil
        }
        
        let deleteAction = UIAction(
            title: "Eliminar",
            image: UIImage(systemName: "trash"),
            attributes: .destructive) { [weak self] _ in
                self?.viewModel.deleteCategory(selectedCategory)
                self?.updateCategories()
            }
        
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil) { _ in
                UIMenu(title: "", children: [deleteAction])
            }
    }
}


