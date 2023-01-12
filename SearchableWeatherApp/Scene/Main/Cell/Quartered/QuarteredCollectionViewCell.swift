//
//  QuarteredCollectionViewCell.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/12.
//

import UIKit

final class QuarteredCollectionViewCell: BaseCollectionViewCell {
    
    lazy var collectionView: UICollectionView = {
      
        let view = UICollectionView(frame: .zero, collectionViewLayout: CustomNSCollectionLayoutSection().quarteredLayout())
        view.backgroundColor = Constants.BaseColor.clear
        view.isScrollEnabled = false
        
        return view
    }()
    
    override func configure() {
        addSubview(collectionView)
        
        collectionView.register(QuarteredItemCell.self, forCellWithReuseIdentifier: QuarteredItemCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension QuarteredCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
      return 4
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuarteredItemCell.reuseIdentifier, for: indexPath) as? QuarteredItemCell else { return UICollectionViewCell() }
        
        let data = QuarteredInfo().quarterInfo
        
        cell.descriptionLabel.text = data[indexPath.item].description
        cell.valueLabel.text = data[indexPath.item].value
        cell.gustLabel.text = data[indexPath.item].gust
        
        return cell
    }
}
