//
//  TimeintervalCollectionViewCell.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import UIKit

class TimeintervalCollectionViewCell: BaseCollectionViewCell {
    let viewModel = MainViewModel()
    
    let background: UIView = {
       let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor(named: "CellBackgroundColor")
        return view
    }()
    
    let windLabel: UILabel = {
       let label = UILabel()
        label.text = "windLabel"
        label.sizeToFit()
        return label
    }()
    
    let separatorLine: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(named: "SearchBarBackgroundColor")
        return view
    }()
    
    let collectionView: UICollectionView = {
      
        let view = UICollectionView(frame: .zero, collectionViewLayout: CustomNSCollectionLayoutSection().horizontalLayout())
        view.backgroundColor = .clear
        
        view.register(TimeintervalItemCell.self, forCellWithReuseIdentifier: TimeintervalItemCell.reuseIdentifier)
       
        return view
    }()
    
    override func configure() {
        backgroundColor = .clear
        
        [background, windLabel,separatorLine,collectionView].forEach {
            addSubview($0)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func setConstraints() {
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        windLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(0.25)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        separatorLine.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(0.5)
            make.centerX.equalToSuperview()
            make.height.equalTo(0.5)
            make.leading.trailing.equalTo(windLabel)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(separatorLine.snp.bottom).offset(20)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
}

extension TimeintervalCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeintervalItemCell.reuseIdentifier, for: indexPath) as? TimeintervalItemCell else { return UICollectionViewCell() }
        
        guard let data = viewModel.currentForecast else { return cell }
        
        if indexPath.row == 0 {
            cell.timeLabel.text = "지금"
        } else {
            cell.timeLabel.text = "\(data[indexPath.row].dt_txt)시"
        }
      
//        cell.weatherImageView.image =
        cell.tempLabel.text = "\(data[indexPath.row].temp)°"
        
        return cell
    }
}
