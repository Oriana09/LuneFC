//
//  ProductDetailsCollectionTableViewCell.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 21/05/2024.
//

import Foundation
import UIKit

protocol ProductDetailsCollectionTableViewCellDelegate: AnyObject {
    func OnAddButtonTap(for type: ProductAttributeType)
    func ButtonDidSeleceted(type: ProductAttributeType, _ title: String)
}

class ProductDetailsCollectionTableViewCell: UITableViewCell {
    
    static let identifier = "AddProductCollectionTableViewCell"
    
    private var model: [String] = []
    private  var inputType: ProductAttributeType?
    private var selectedIndex: IndexPath?
    weak var delegate: ProductDetailsCollectionTableViewCellDelegate?
    
    
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
        collectionView.register(ProductoDetailsCollectionViewCell.self, forCellWithReuseIdentifier: ProductoDetailsCollectionViewCell.identifier)
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
        
        let padding: CGFloat = 8
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: padding),
            self.collectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: padding),
            self.collectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: padding),
            self.collectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -padding)
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
extension ProductDetailsCollectionTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductoDetailsCollectionViewCell.identifier,
            for: indexPath
        ) as! ProductoDetailsCollectionViewCell
        
        
        if let selectedIndex = selectedIndex, indexPath == selectedIndex {
            cell.configure(
                with: self.model[indexPath.item],
                isSelected: true
            )
            
            self.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
            self.collectionView.delegate?.collectionView?(collectionView, didSelectItemAt: indexPath)
        } else if inputType == .style, indexPath.item == self.model.count - 2 {
           
            selectedIndex = indexPath
            cell.configure(
                with: self.model[indexPath.item],
                isSelected: true
            )
            
            DispatchQueue.main.async {
                  self.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
                  self.collectionView.delegate?.collectionView?(self.collectionView, didSelectItemAt: indexPath)
              }
        } else {
            cell.configure(
                with: self.model[indexPath.item],
                isSelected: false
            )
        }
        
        return cell
        
    }
}
// MARK: - UICollectionViewDataSource - UICollectionViewDelegate

extension ProductDetailsCollectionTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
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
            let previousCell = collectionView.cellForItem(at: previousIndex) as? ProductoDetailsCollectionViewCell
            
            previousCell?.configure(
                with: model[previousIndex.item],
                isSelected: false
            )
        }
        
        selectedIndex = indexPath
        
        guard let selectedCell = collectionView.cellForItem(
            at: indexPath
        ) as? ProductoDetailsCollectionViewCell else {
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



