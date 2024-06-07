//
//  AddProductItemTableViewCell.swift
//  LuneFcClothes
//
//  Created by Oriana Costancio on 21/05/2024.
//

import Foundation
import UIKit

class SizesCollectionTableViewCell: UITableViewCell {
    
    static let identifier = "SizesCollectionTableViewCell"
    
    private var model: Category = Category()
    
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
        collectionView.register(SizeCollectionViewCell.self, forCellWithReuseIdentifier: SizeCollectionViewCell.identifier)
        
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
    
    func configure(with model: Category) {
        self.model = model
        self.collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension SizesCollectionTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model.sizes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SizeCollectionViewCell.identifier, for: indexPath) as! SizeCollectionViewCell
        let isSelected = indexPath == selectedIndex
        cell.configure(with: self.model.sizes[indexPath.item], isSelected: isSelected)
        return cell
    }
}

// MARK: - UICollectionViewDataSource - UICollectionViewDelegate

extension SizesCollectionTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let previousIndex = selectedIndex {
            let previousCell = collectionView.cellForItem(at: previousIndex) as? SizeCollectionViewCell
            previousCell?.configure(with: model.sizes[previousIndex.item], isSelected: false)
        }
        
        selectedIndex = indexPath
        
        let selectedCell = collectionView.cellForItem(at: indexPath) as? SizeCollectionViewCell
        selectedCell?.configure(with: model.sizes[indexPath.item], isSelected: true)
        
        self.collectionView.performBatchUpdates(nil, completion: nil)
    }
}
