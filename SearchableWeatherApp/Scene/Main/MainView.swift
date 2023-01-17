//
//  MainView.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import UIKit

final class MainView: BaseView {
    
    let viewModel = MainViewModel()
    
    private var refreshControl = UIRefreshControl()
    
    let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 28, height: 0))
    
    let collectionView: UICollectionView = {
        let refreshControl = UIRefreshControl()
        let view = UICollectionView(frame: .zero, collectionViewLayout: CustomNSCollectionLayoutSection().getSectionLayout())
        view.backgroundColor = Constants.BaseColor.clear
        
        view.register(CurrentLocationWeatherCollectionViewCell.self, forCellWithReuseIdentifier: CurrentLocationWeatherCollectionViewCell.reuseIdentifier)
        view.register(TimeIntervalCollectionViewCell.self, forCellWithReuseIdentifier: TimeIntervalCollectionViewCell.reuseIdentifier)
        view.register(DayIntervalCollectionViewCell.self, forCellWithReuseIdentifier: DayIntervalCollectionViewCell.reuseIdentifier)
        view.register(MapCollectionViewCell.self, forCellWithReuseIdentifier: MapCollectionViewCell.reuseIdentifier)
        view.register(QuarteredCollectionViewCell.self, forCellWithReuseIdentifier: QuarteredCollectionViewCell.reuseIdentifier)
        
        view.refreshControl = refreshControl
        
        return view
        
    }()
    
    @objc func refresh(refresh: UIRefreshControl) {
        DispatchQueue.main.async {

            
            refresh.endRefreshing()
        }
        self.viewModel.requestAPI()
        collectionView.reloadData()
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
