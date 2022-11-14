//
//  HomeViewController+Layout.swift
//  DatingApp
//
//  Created by Er. Abhishek Chandani on 12/11/22.
//

import Foundation
import UIKit

extension HomeViewController {
    
    func homePageLayout()->UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnv) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0:
                return self.pictureLayout(section: sectionIndex)
            case 1:
                return self.profileInterestsLayout()
            case 2:
                return self.aboutSectionLayout()
            default:
                return nil
            }
        }
        return layout
    }
    
    private func pictureLayout(section: Int)->NSCollectionLayoutSection {
        if picturesMode == .full {
            return singlePageLayout()
        }
        switch collectionView.numberOfItems(inSection: section) {
        case 2:
            return twoItemsLayout()
        case 3:
            return threeItemsLayout()
        case 4:
            return fourItemsLayout()
        default:
            return twoItemsLayout()
        }
    }
    
    func threeItemsLayout()-> NSCollectionLayoutSection {
        
        //1st Image Item
        let topItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                 heightDimension: .fractionalHeight(1))
        let topTime = NSCollectionLayoutItem(layoutSize: topItemSize)
                
        //2nd Bottom left Image Item
        let bottomLeftItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                        heightDimension: .fractionalHeight(1))
        let bottomLeftItem = NSCollectionLayoutItem(layoutSize: bottomLeftItemSize)
        bottomLeftItem.contentInsets = NSDirectionalEdgeInsets.init(top: 8, leading: 0, bottom: 8, trailing: 4)
        
        //3rd Bottom right Image Item
        let bottomRightItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                         heightDimension: .fractionalHeight(1))
        let bottomRightItem = NSCollectionLayoutItem(layoutSize: bottomRightItemSize)
        bottomRightItem.contentInsets = NSDirectionalEdgeInsets.init(top: 8, leading: 4, bottom: 8, trailing: 0)
        
        //Top Item group
        let topItemGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                                 heightDimension: .fractionalHeight(0.6)),
                                                            subitems: [topTime])

        //Bottom Item group
        let bottomItemGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                                    heightDimension: .fractionalHeight(0.4)),
                                                            subitems: [bottomLeftItem, bottomRightItem])

        //Main Group Top + Bottom
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.65))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize:
                                                            groupSize,
                                                         subitems: [topItemGroup, bottomItemGroup])
        //1st Section with Three Items
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 8, leading: 16, bottom: 8, trailing: 16)
        return section
    }
    
    func fourItemsLayout()-> NSCollectionLayoutSection {
        
        //1st Image Item
        let topItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                 heightDimension: .fractionalHeight(1))
        let topTime = NSCollectionLayoutItem(layoutSize: topItemSize)
                
        //2nd Bottom left Image Item
        let bottomLeftItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                        heightDimension: .fractionalHeight(1))
        let bottomLeftItem = NSCollectionLayoutItem(layoutSize: bottomLeftItemSize)
        bottomLeftItem.contentInsets = NSDirectionalEdgeInsets.init(top: 8, leading: 0, bottom: 8, trailing: 4)
        
        //3rd Bottom right Image Item
        let bottomRightItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                         heightDimension: .fractionalHeight(1))
        let bottomRightItem = NSCollectionLayoutItem(layoutSize: bottomRightItemSize)
        bottomRightItem.contentInsets = NSDirectionalEdgeInsets.init(top: 8, leading: 4, bottom: 8, trailing: 0)
        
        //Top Item group
        let topItemGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                                 heightDimension: .fractionalHeight(0.33)),
                                                            subitems: [topTime])

        //Bottom Item group
        let middleItemGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                                    heightDimension: .fractionalHeight(0.33)),
                                                            subitems: [bottomLeftItem, bottomRightItem])

        //Main Group Top + Bottom
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.7))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize:
                                                            groupSize,
                                                         subitems: [topItemGroup, middleItemGroup, topItemGroup])
        //1st Section with Three Items
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 8, leading: 16, bottom: 8, trailing: 16)
        return section
    }
    
    func singlePageLayout()->NSCollectionLayoutSection {
        //1st Image Item
        let topItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                 heightDimension: .fractionalHeight(1))
        let topTime = NSCollectionLayoutItem(layoutSize: topItemSize)
        topTime.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 20, bottom: 10, trailing: 20)
        //Top Item group
        let topItemGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                                 heightDimension: .fractionalHeight(1)),
                                                            subitems: [topTime])

        //Main Group Top + Bottom
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.65))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize:
                                                            groupSize,
                                                         subitems: [topItemGroup])
        //1st Section with Three Items
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section

    }
    
    func twoItemsLayout()-> NSCollectionLayoutSection {
        
        //1st Image Item
        let topItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                 heightDimension: .fractionalHeight(1))
        let topTime = NSCollectionLayoutItem(layoutSize: topItemSize)
        topTime.contentInsets = NSDirectionalEdgeInsets.init(top: 4, leading: 0, bottom: 4, trailing: 0)
        //Top Item group
        let topItemGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                                 heightDimension: .fractionalHeight(0.5)),
                                                            subitems: [topTime])

        //Main Group Top + Bottom
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.7))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize:
                                                            groupSize,
                                                         subitems: [topItemGroup, topItemGroup])
        //1st Section with Three Items
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 8, leading: 16, bottom: 8, trailing: 16)
        return section
    }


    func aboutSectionLayout()-> NSCollectionLayoutSection {
        
        //Text Label Size
        let textItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                 heightDimension: .estimated(50))
        let textItem = NSCollectionLayoutItem(layoutSize: textItemSize)

        //Text Label Single Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(50))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize:
                                                            groupSize,
                                                         subitems: [textItem])
        //Header boundary Item
        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: AboutSectionReusableView.reuseIdentifier, alignment: .top)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.boundarySupplementaryItems = [headerItem]
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 80, trailing: 0)
        return section
    }
    
    func profileInterestsLayout()-> NSCollectionLayoutSection {
        
        //Text Label Size
        let textItemSize = NSCollectionLayoutSize(widthDimension: .estimated(50),
                                                 heightDimension: .fractionalHeight(1))
        let textItem = NSCollectionLayoutItem(layoutSize: textItemSize)

        //Text Label Single Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(30))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize:
                                                            groupSize,
                                                         subitems: [textItem])
        group.interItemSpacing = .fixed(8)
        //Header boundary Item
        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: ProfileInfoReusableView.reuseIdentifier, alignment: .top)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15
        section.boundarySupplementaryItems = [headerItem]
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 8, leading: 20, bottom: 8, trailing: 20)
        return section
    }

    
}

enum PictureLayout {
    case two
    case three
    case four
}
