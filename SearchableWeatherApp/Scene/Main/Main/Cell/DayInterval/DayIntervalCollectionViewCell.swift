//
//  DayIntervalCollectionViewCell.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/12.
//

import UIKit

import RealmSwift

final class DayIntervalCollectionViewCell: BaseCollectionViewCell {
    lazy var viewModel = MainViewModel()
    
    let repository = ForecastRepository()
    
    let background: UIView = {
       let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = Constants.BaseColor.cellBackgroundColor
        return view
    }()
    
    let dayLabel: UILabel = {
       let label = UILabel()
        label.text = "5일간의 일기예보"
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.sizeToFit()
        return label
    }()
    
    let separatorLine: UIView = {
       let view = UIView()
        view.backgroundColor = Constants.BaseColor.searchBarBackgroundColor
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
      
        let view = UICollectionView(frame: .zero, collectionViewLayout: CustomNSCollectionLayoutSection().verticalLayout())
        view.backgroundColor = Constants.BaseColor.clear
        view.isScrollEnabled = false
        
        return view
    }()
    
    override func configure() {
        backgroundColor = Constants.BaseColor.clear
        
        [background, dayLabel,separatorLine,collectionView].forEach {
            addSubview($0)
        }
        
        collectionView.register(DayIntervalItemCell.self, forCellWithReuseIdentifier: DayIntervalItemCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func setConstraints() {
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        dayLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(0.2)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        separatorLine.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(0.4)
            make.centerX.equalToSuperview()
            make.height.equalTo(0.5)
            make.leading.trailing.equalTo(dayLabel)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(separatorLine.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(4)
            make.leading.trailing.equalToSuperview()
        }
    }
    
   
}

extension DayIntervalCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if User.tempMin == 0 {
            return 0
        } else {
            lazy var fiveDays: [Forecast] = viewModel.loadFiveDays()
            
            return fiveDays.count
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayIntervalItemCell.reuseIdentifier, for: indexPath) as? DayIntervalItemCell else { return UICollectionViewCell() }
        
        lazy var fiveDays: [Forecast] = viewModel.loadFiveDays()
        

        print(fiveDays)
        if indexPath.item == 0 {
            cell.dayLabel.text = "오늘"
        } else {
            
            guard let time = fiveDays[indexPath.item].dt_txt.dateFormatToDay() else { return cell }
            
            
            
            cell.dayLabel.text = "\(time)"
        }
        
        
        cell.weatherImageView.image = UIImage(named: "\(fiveDays[indexPath.item].icon)")
        cell.tempMinLabel.text = "최소: \(Int(fiveDays[indexPath.item].temp_min))°"
        cell.tempMaxLabel.text = "최대: \(Int(fiveDays[indexPath.item].temp_max))°"
        
        return cell
    }
}
