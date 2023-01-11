//
//  TimeIntervalCollectionViewCell.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import UIKit

import RealmSwift

class TimeIntervalCollectionViewCell: BaseCollectionViewCell {
    lazy var viewModel = MainViewModel()
    
    let repository = ForecastRepository()
    
    let background: UIView = {
       let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = Constants.BaseColor.cellBackgroundColor
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
        view.backgroundColor = Constants.BaseColor.searchBarBackgroundColor
        return view
    }()
    
    let collectionView: UICollectionView = {
      
        let view = UICollectionView(frame: .zero, collectionViewLayout: CustomNSCollectionLayoutSection().horizontalLayout())
        view.backgroundColor = Constants.BaseColor.clear
        
       
        return view
    }()
    
    override func configure() {
        backgroundColor = Constants.BaseColor.clear
        
        [background, windLabel,separatorLine,collectionView].forEach {
            addSubview($0)
        }
        
        collectionView.register(TimeIntervalItemCell.self, forCellWithReuseIdentifier: TimeIntervalItemCell.reuseIdentifier)
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
            make.top.equalTo(separatorLine.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(4)
            make.leading.trailing.equalToSuperview()
        }
    }
}

extension TimeIntervalCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let data = repository.fetch()
        if data.count > 15 {
            return 16
        } else {
            return 0
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeIntervalItemCell.reuseIdentifier, for: indexPath) as? TimeIntervalItemCell else { return UICollectionViewCell() }
        
        let data = repository.fetch()
        
        if indexPath.item == 0 {
            cell.timeLabel.text = "지금"
        } else {
            let distanceHour = Calendar.current.dateComponents([.hour], from: Date(), to: data[indexPath.item].dt_txt).hour
            
            guard let distanceTime = distanceHour else { return cell }
            
            if distanceTime < 1 {
                repository.deleteById(id: data[indexPath.item].objectId)
        
                collectionView.reloadData()
            }
            
            guard let time = data[indexPath.item].dt_txt.dateFormatToTime() else { return cell }
            print(time, distanceHour, indexPath.item)
          
            
            cell.timeLabel.text = "\(time)시"
        }
        
        
        cell.weatherImageView.image = UIImage(named: "\(data[indexPath.item].icon)")
        cell.tempLabel.text = "\(Int(data[indexPath.item].temp))°"
        
        return cell
    }
}
