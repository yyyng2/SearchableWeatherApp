//
//  DayIntervalItemCell.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/12.
//

import UIKit

class DayIntervalItemCell: BaseCollectionViewCell {
    
    let dayLabel: UILabel = {
       let label = UILabel()
        label.text = "오늘"
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    let weatherImageView: UIImageView = {
       let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let tempMinLabel: UILabel = {
       let label = UILabel()
        label.text = "temp_min"
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textAlignment = .center
        return label
    }()
    
    let tempMaxLabel: UILabel = {
       let label = UILabel()
        label.text = "temp_max"
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    override func configure() {
        [dayLabel, weatherImageView, tempMinLabel, tempMaxLabel].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        dayLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
        }
        weatherImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().multipliedBy(0.8)
            make.top.bottom.equalToSuperview()
        }
        tempMinLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.22)
            make.trailing.equalTo(tempMaxLabel.snp.leading).inset(4)
        }
        tempMaxLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.22)
            make.trailing.equalToSuperview().inset(10)
        }
    }
  
    
}
