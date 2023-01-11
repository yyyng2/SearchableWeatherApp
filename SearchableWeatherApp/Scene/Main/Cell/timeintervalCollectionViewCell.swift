//
//  timeintervalCollectionViewCell.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import UIKit

class timeintervalCollectionViewCell: BaseCollectionViewCell {
    let windLabel: UILabel = {
       let label = UILabel()
        label.text = "windLabel"
        return label
    }()
    let separatorLine: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(named: "SearchBarBackgroundColor")
        return view
    }()
    
}
