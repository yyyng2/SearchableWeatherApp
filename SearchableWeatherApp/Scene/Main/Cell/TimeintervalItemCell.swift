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
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    let weatherImageView: UIImageView = {
       let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let tempLabel: UILabel = {
       let label = UILabel()
        label.text = "temp"
        label.textAlignment = .center
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
            make.centerY.equalToSuperview().multipliedBy(0.2)
            make.horizontalEdges.equalToSuperview()
        }
        weatherImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(timeLabel.snp.bottom)
            make.bottom.equalTo(tempLabel.snp.top)
        }
        tempLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(weatherImageView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
        }
    }
  
    
}
