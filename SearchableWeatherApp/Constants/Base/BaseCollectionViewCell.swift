//
//  BaseCollectionViewCell.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Constants.BaseColor.clear
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func configure() { }
    
    internal func setConstraints() { }
    
}
