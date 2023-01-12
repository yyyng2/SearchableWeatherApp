//
//  QuarteredItemCell.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/12.
//

import UIKit

final class QuarteredItemCell: BaseCollectionViewCell {
    let background: UIView = {
       let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = Constants.BaseColor.cellBackgroundColor
        return view
    }()
    
    let descriptionLabel: UILabel = {
       let label = UILabel()
        label.text = "description"
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.sizeToFit()
        return label
    }()
    
    let valueLabel: UILabel = {
       let label = UILabel()
        label.text = "value"
        label.font = .systemFont(ofSize: 28, weight: .regular)
        label.sizeToFit()
        return label
    }()
    
    let gustLabel: UILabel = {
       let label = UILabel()
        label.text = "gust"
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.sizeToFit()
        return label
    }()
    
    override func configure() {
        [background, descriptionLabel, valueLabel, gustLabel].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        descriptionLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(0.2)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        valueLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        gustLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview().multipliedBy(1.8)
            make.centerX.equalToSuperview()
        }
    }
}
