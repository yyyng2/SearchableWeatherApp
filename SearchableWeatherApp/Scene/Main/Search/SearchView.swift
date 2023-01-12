//
//  SearchView.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/12.
//

import UIKit

final class SearchView: BaseView {
    
    let viewModel = MainViewModel()
    
    let collectionView: UICollectionView = {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.backgroundColor = UIColor.clear
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout.list(using: configuration))
        view.backgroundColor = Constants.BaseColor.clear
        
        view.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.reuseIdentifier)
      
        return view
        
    }()
    
    let searchBar: UISearchController = {
        
       let bar = UISearchController()
        
        //CancelButton Color
        bar.searchBar.setValue("Cancel", forKey: "cancelButtonText")
        bar.searchBar.tintColor = .systemGray2
        
        //placeholder Color
        bar.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray2])
        bar.searchBar.searchTextField.backgroundColor = Constants.BaseColor.searchBarBackgroundColor
        
        //Magnifying Icon Color
        let magnifyingIconView = bar.searchBar.searchTextField.leftView as! UIImageView
        magnifyingIconView.image = magnifyingIconView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        magnifyingIconView.tintColor = .systemGray2
        
        return bar
        
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
