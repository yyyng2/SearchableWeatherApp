//
//  CurrentLocationWeatherCollectionViewCell.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import UIKit

class CurrentLocationWeatherCollectionViewCell: BaseCollectionViewCell {
    let cityLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 36, weight: .medium)
        label.text = "city"
        label.textAlignment = .center
        return label
    }()
    
    let tempLabel: UILabel = {
       let label = UILabel()
        label.text = "temp"
        label.font = .systemFont(ofSize: 52, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    let stateLabel: UILabel = {
       let label = UILabel()
        label.text = "state"
        label.font = .systemFont(ofSize: 28, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    let maxMinLabel: UILabel = {
       let label = UILabel()
        label.text = "maxMin"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    override func configure() {
        [cityLabel, tempLabel, stateLabel, maxMinLabel].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        cityLabel.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(0.3)
            make.leading.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide)
        }
        tempLabel.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(0.8)
            make.leading.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide)
        }
        stateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(1.4)
            make.leading.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide)
        }
        maxMinLabel.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(1.8)
            make.leading.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide)
        }
    }
}
