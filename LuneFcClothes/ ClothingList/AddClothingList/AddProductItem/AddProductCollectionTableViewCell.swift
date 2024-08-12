//
//  AddProductItemTableViewCell.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 21/05/2024.
//

import Foundation
import UIKit

protocol AddProductCollectionTableViewCellDelegate: AnyObject {
    func OnAddButtonTap(for type: ProductAttributeType)
    func ButtonDidSeleceted(type: ProductAttributeType, _ title: String)
}

class AddProductCollectionTableViewCell: UITableViewCell {
    
    static let identifier = "AddProductCollectionTableViewCell"
    
    private var model: [String] = []
    private  var inputType: ProductAttributeType?
    private var selectedIndex: IndexPath?
    weak var delegate: AddProductCollectionTableViewCellDelegate?
    
    
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
        collectionView.register(AddProductCollectionViewCell.self, forCellWithReuseIdentifier: AddProductCollectionViewCell.identifier)
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
    
    func configure(with model: [String], inputType: ProductAttributeType) {
        self.model = model
        self.model.append("+")
        self.inputType = inputType
        self.collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension AddProductCollectionTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AddProductCollectionViewCell.identifier,
            for: indexPath
        ) as! AddProductCollectionViewCell
        
        
        if let selectedIndex = selectedIndex, indexPath == selectedIndex {
               cell.configure(
                   with: self.model[indexPath.item],
                   isSelected: true
               )
        } else if inputType == .style, indexPath.item == self.model.count - 2 {
               // Aquí seleccionas automáticamente el penúltimo ítem, asumiendo que el último es el botón "+"
               selectedIndex = indexPath
               cell.configure(
                   with: self.model[indexPath.item],
                   isSelected: true
               )
           } else {
               cell.configure(
                   with: self.model[indexPath.item],
                   isSelected: false
               )
           }

           return cell
//        let isSelected = indexPath == selectedIndex
//        cell.configure(
//            with: self.model[indexPath.item],
//           isSelected: isSelected
//        )
//        return cell
//
    }
}
// MARK: - UICollectionViewDataSource - UICollectionViewDelegate

extension AddProductCollectionTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard indexPath.row != self.model.count - 1 else {
            
            if let inputType = self.inputType {
                self.delegate?.OnAddButtonTap(for: inputType)
            }
            return
        }
        
        if let previousIndex = selectedIndex {
            let previousCell = collectionView.cellForItem(at: previousIndex) as? AddProductCollectionViewCell
            
            previousCell?.configure(
                with: model[previousIndex.item],
                isSelected: false
            )
        }

        selectedIndex = indexPath
        
        guard let selectedCell = collectionView.cellForItem(
            at: indexPath
        ) as? AddProductCollectionViewCell else {
            return
        }
        selectedCell.configure(
            with: model[indexPath.item],
            isSelected: true
        )
        
        self.delegate?.ButtonDidSeleceted(
            type: self.inputType ?? .size,
            selectedCell.label.text ?? "Default Text"
        )
        
        self.collectionView.performBatchUpdates(nil, completion: nil)
    }
}



