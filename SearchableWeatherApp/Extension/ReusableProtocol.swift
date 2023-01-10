//
//  ReusableProtocol.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import UIKit

protocol ReusableViewProtocol: AnyObject {
    static var reuseIdentifier: String{ get }
}

extension UICollectionViewCell: ReusableViewProtocol {
    static var reuseIdentifier: String{
        return String(describing: self)
    }
}
