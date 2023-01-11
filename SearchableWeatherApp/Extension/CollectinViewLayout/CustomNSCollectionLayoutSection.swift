//
//  CustomNSCollectionLayoutSection.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import UIKit

class CustomNSCollectionLayoutSection {
    
    func getLayout() -> UICollectionViewCompositionalLayout {
        
      UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
          
        switch section {
            
        case 0:
            let itemFractionalWidthFraction = 1.0 / 1.0
            let groupFractionalHeightFraction = 1.0 / 4.0
            let itemInset: CGFloat = 2.5
            
            // Item
            let itemSize = NSCollectionLayoutSize(
              widthDimension: .fractionalWidth(itemFractionalWidthFraction),
              heightDimension: .fractionalHeight(1)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
            
            // Group
            let groupSize = NSCollectionLayoutSize(
              widthDimension: .fractionalWidth(1),
              heightDimension: .fractionalHeight(groupFractionalHeightFraction)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
            return section
            
        case 5:
            
          let itemFractionalWidthFraction = 1.0 / 1.0
          let groupFractionalHeightFraction = 1.0 / 11.0
          let itemInset: CGFloat = 2
          
          // Item
          let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemFractionalWidthFraction),
            heightDimension: .fractionalHeight(1)
          )
          let item = NSCollectionLayoutItem(layoutSize: itemSize)
          item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
          
          // Group
          let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(groupFractionalHeightFraction)
          )
          let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
          
          // Section
    //            var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
    //            configuration.backgroundColor = .clear
    //            configuration.separatorConfiguration.color = .gray
    //            configuration.headerMode = .firstItemInSection
    //            let section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: env)
            let section = NSCollectionLayoutSection(group: group)
          section.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: 20, bottom: itemInset, trailing: 20)
          return section
            
        default:
            
          let itemFractionalWidthFraction = 1.0 / 5.0
          let groupFractionalHeightFraction = 1.0 / 4.0
          let itemInset: CGFloat = 2.5
          
          // Item
          let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemFractionalWidthFraction),
            heightDimension: .fractionalHeight(1)
          )
          let item = NSCollectionLayoutItem(layoutSize: itemSize)
          item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
          
          // Group
          let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(groupFractionalHeightFraction)
          )
          let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
          
          // Section
          let section = NSCollectionLayoutSection(group: group)
          section.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
          return section
            
        }
      }
    }

}
