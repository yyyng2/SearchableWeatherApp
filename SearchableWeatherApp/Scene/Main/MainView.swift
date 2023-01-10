//
//  MainView.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import UIKit

class MainView: BaseView {
    
    let searchBar: UISearchController = {
       let bar = UISearchController()
        
        //CancelButton Color
        bar.searchBar.setValue("Cancel", forKey: "cancelButtonText")
        bar.searchBar.tintColor = .systemGray2
        
        //placeholder Color
        bar.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray2])
        bar.searchBar.searchTextField.backgroundColor = UIColor(named: "SearchBarBackgroundColor")
        
        //Magnifying Icon Color
        let magnifyingIconView = bar.searchBar.searchTextField.leftView as! UIImageView
        magnifyingIconView.image = magnifyingIconView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        magnifyingIconView.tintColor = .systemGray2
        
        return bar
    }()
    
    let label: UILabel = {
       let label = UILabel()
        label.text = "test"
        label.textAlignment = .center
        return label
    }()
    
    override internal func configure() {
        backgroundColor = UIColor(named: "BackgroundColor")
        [label].forEach {
            self.addSubview($0)
        }
    }
    
    override internal func setConstraints() {
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
}
