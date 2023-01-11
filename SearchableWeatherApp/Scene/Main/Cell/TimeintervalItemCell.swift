//
//  TimeintervalItemCell.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import UIKit

class TimeintervalItemCell: BaseCollectionViewCell {
    
    let timeLabel: UILabel = {
       let label = UILabel()
        label.text = "지금"
        return label
    }()
    
    let weatherImageView: UIImageView = {
       let view = UIImageView()
        return view
    }()
    
    let tempLabel: UILabel = {
       let label = UILabel()
        label.text = "temp"
        return label
    }()
    
    override func configure() {
        [timeLabel, weatherImageView, tempLabel].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        timeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.4)
            make.horizontalEdges.equalToSuperview()
        }
        weatherImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
        tempLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(1.6)
            make.horizontalEdges.equalToSuperview()
        }
    }
  
    
}
