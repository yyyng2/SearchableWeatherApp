//
//  SearchCollectionViewCell.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import UIKit

import SnapKit

final class SearchCollectionViewCell: BaseCollectionViewCell {
    
    let cityLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "city"
        return label
    }()
    
    let countryLabel: UILabel = {
       let label = UILabel()
        label.text = "country"
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    let separatorLine: UIView = {
       let view = UIView()
        view.backgroundColor = Constants.BaseColor.searchBarBackgroundColor
        return view
    }()
    
    override func configure() {
        [cityLabel, countryLabel, separatorLine].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        cityLabel.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(0.5)
            make.leading.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide)
        }
        countryLabel.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(1.5)
            make.leading.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide)
        }
        separatorLine.snp.makeConstraints { make in
            make.leading.trailing.equalTo(countryLabel)
            make.top.equalTo(countryLabel.snp.bottom).offset(10)
            make.height.equalTo(0.5)
        }
    }
    
}
