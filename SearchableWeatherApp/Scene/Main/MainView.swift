//
//  MainView.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import UIKit

class MainView: BaseView {
    
    let searchBar: UISearchController = {
        
       let bar = UISearchController()
        
        //CancelButton Color
        bar.searchBar.setValue("Cancel", forKey: "cancelButtonText")
        bar.searchBar.tintColor = .systemGray2
        
        //placeholder Color
        bar.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray2])
        bar.searchBar.searchTextField.backgroundColor = UIColor(named: "SearchBarBackgroundColor")
        
        //Magnifying Icon Color
        let magnifyingIconView = bar.searchBar.searchTextField.leftView as! UIImageView
        magnifyingIconView.image = magnifyingIconView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        magnifyingIconView.tintColor = .systemGray2
        
        return bar
        
    }()
    
    let collectionView: UICollectionView = {
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: CustomNSCollectionLayoutSection().getLayout())
        view.backgroundColor = .clear
        
        view.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.reuseIdentifier)
        view.register(CurrentLocationWeatherCollectionViewCell.self, forCellWithReuseIdentifier: CurrentLocationWeatherCollectionViewCell.reuseIdentifier)
        view.register(timeintervalCollectionViewCell.self, forCellWithReuseIdentifier: timeintervalCollectionViewCell.reuseIdentifier)
        return view
        
    }()
    
    override internal func configure() {
        
        backgroundColor = UIColor(named: "BackgroundColor")
        
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
