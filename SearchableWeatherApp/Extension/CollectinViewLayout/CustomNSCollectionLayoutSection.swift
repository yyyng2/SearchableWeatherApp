//
//  CustomNSCollectionLayoutSection.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import UIKit

class CustomNSCollectionLayoutSection {
    
    func getSectionLayout() -> UICollectionViewCompositionalLayout {
        
        UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
            let viewModel = MainViewModel()
            switch viewModel.isSearching {
            case true:
                
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
                
            case false:
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
                    
                case 1:
                    let itemFractionalWidthFraction = 1.0 / 1.0
                    let groupFractionalHeightFraction = 1.0 / 6.0
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
                    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                    
                    // Section
                    let section = NSCollectionLayoutSection(group: group)
                    section.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: 10, bottom: itemInset, trailing: 10)
                    return section
                    
                case 2:
                    
                    let itemFractionalWidthFraction = 1.0 / 1.0
                    let groupFractionalHeightFraction = 1.0 / 3.0
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
                    section.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: 10, bottom: itemInset, trailing: 10)
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
    
    func horizontalLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/6.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    func verticalLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0/5.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 20)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
}
