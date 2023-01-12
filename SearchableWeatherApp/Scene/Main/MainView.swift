//
//  MainView.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import UIKit

class MainView: BaseView {
    
    let viewModel = MainViewModel()
    
    private var refreshControl = UIRefreshControl()
    
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
    
    let collectionView: UICollectionView = {
        let refreshControl = UIRefreshControl()
        let view = UICollectionView(frame: .zero, collectionViewLayout: CustomNSCollectionLayoutSection().getSectionLayout())
        view.backgroundColor = Constants.BaseColor.clear
        
        view.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.reuseIdentifier)
        view.register(CurrentLocationWeatherCollectionViewCell.self, forCellWithReuseIdentifier: CurrentLocationWeatherCollectionViewCell.reuseIdentifier)
        view.register(TimeIntervalCollectionViewCell.self, forCellWithReuseIdentifier: TimeIntervalCollectionViewCell.reuseIdentifier)
        view.register(DayIntervalCollectionViewCell.self, forCellWithReuseIdentifier: DayIntervalCollectionViewCell.reuseIdentifier)
        view.register(MapCollectionViewCell.self, forCellWithReuseIdentifier: MapCollectionViewCell.reuseIdentifier)
        view.register(QuarteredCollectionViewCell.self, forCellWithReuseIdentifier: QuarteredCollectionViewCell.reuseIdentifier)
        
        view.refreshControl = refreshControl
        
        return view
        
    }()
    
    @objc func refresh(refresh: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.viewModel.requestAPI(requestStyle: .userRequest, collectionView: self.collectionView)
          
            refresh.endRefreshing()
        }
        
    }
    
    override internal func configure() {
        
        backgroundColor = Constants.BaseColor.backgroundColor
        
        [collectionView].forEach {
            self.addSubview($0)
        }
        
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh(refresh:)), for: .valueChanged)
        
    }
    
    override internal func setConstraints() {
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
}
