//
//  MainView.swift
//  FearExperience
//
//  Created by Aji Saputra Raka Siwi on 25/03/20.
//  Copyright © 2020 Untitled. All rights reserved.
//

import UIKit

class MainView: BaseView {
    
    lazy var experienceCollectionView: UICollectionView = {
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        collectionview.register(CardCell.self, forCellWithReuseIdentifier: experienceCellId)
        collectionview.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        collectionview.showsVerticalScrollIndicator = false
        return collectionview
    }()

    override func setupView() {
        self.backgroundColor = .black
        self.addSubview(experienceCollectionView)
        
        experienceCollectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        experienceCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        experienceCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        experienceCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
