//
//  AddProductItemTableViewCell.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 21/05/2024.
//

import Foundation
import UIKit

protocol CollectionTableViewCellDelegate: AnyObject {
    func onAddButtonTap(for type: InputType)
}

class CollectionTableViewCell: UITableViewCell {
    
    static let identifier = "CollectionTableViewCell"
    
    private var model: [String] = []
    weak var delegate: CollectionTableViewCellDelegate?
    var inputType: InputType?
    
    private var selectedIndex: IndexPath?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
//        collectionView.register(AddButtonCollectionViewCell.self, forCellWithReuseIdentifier: AddButtonCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        self.contentView.addSubview(self.collectionView)
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
    }
    
    func configure(with model: [String], inputType: InputType) {
        self.model = model
        self.model.append("+")
        self.inputType = inputType
        self.collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension CollectionTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CollectionViewCell.identifier,
                for: indexPath
            ) as! CollectionViewCell
            let isSelected = indexPath == selectedIndex
            cell.configure(
                with: self.model[indexPath.item],
                isSelected: isSelected
            )
            return cell
            
    }
}
// MARK: - UICollectionViewDataSource - UICollectionViewDelegate

extension CollectionTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard indexPath.row != self.model.count - 1 else {
            //Avistar al VC que presente la alerta
            if let inputType = self.inputType {
                self.delegate?.onAddButtonTap(for: inputType)
            }
            return
        }
        
        if let previousIndex = selectedIndex {
            let previousCell = collectionView.cellForItem(at: previousIndex) as? CollectionViewCell
            previousCell?.configure(with: model[previousIndex.item], isSelected: false)
        }
        
        selectedIndex = indexPath
        
        let selectedCell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell
        selectedCell?.configure(
            with: model[indexPath.item],
            isSelected: true
        )
        
        self.collectionView.performBatchUpdates(nil, completion: nil)
    }
}

//MARK: - AddButtonCollectionViewCellDelegate

//extension CollectionTableViewCell: AddButtonCollectionViewCellDelegate {
//    
//    func didTapAddButton(in cell: AddButtonCollectionViewCell) {
//        guard let viewController = self.window?.rootViewController as? AddProductItemViewController else {
//            return
//        }
//        viewController.presentAddColorAlert(for: <#InputType#>)
//    }
//}




