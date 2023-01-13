//
//  SearchView.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/12.
//

import UIKit

final class SearchView: BaseView {
    
    let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 120, height: 0))
    
    let cancelButton = UIBarButtonItem(title: "Cancel")
    
    let collectionView: UICollectionView = {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.backgroundColor = UIColor.clear
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout.list(using: configuration))
        view.backgroundColor = Constants.BaseColor.clear
        
        view.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.reuseIdentifier)
      
        return view
        
    }()
    
    override internal func configure() {
        
        backgroundColor = Constants.BaseColor.backgroundColor
        
        [collectionView].forEach {
            self.addSubview($0)
        }
        
    }
    
    override internal func setConstraints() {
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
}
