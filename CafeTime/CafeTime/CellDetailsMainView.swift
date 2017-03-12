//
//  CellDetailsMainView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/27/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

class CellDetailsMainView: UIView {
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews([topImageView, infoContainerView, favoritesButton, chatButton, collectionView])
        self.backgroundColor = UIColor.lightGray
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Vars
    
    private let chatButton: UIButton = {
        let myVar = UIButton()
        myVar.backgroundColor = UIColor.red
        myVar.contentMode = .scaleToFill
        return myVar
    }()
    
    private let favoritesButton: UIButton = {
        let myVar = UIButton()
        myVar.backgroundColor = UIColor.red
        myVar.contentMode = .scaleToFill
        return myVar
    }()
    
    private var topImageView: UIImageView = {
        let myVar = UIImageView()
        myVar.image = UIImage(named: "superSandwich")
        myVar.contentMode = .scaleToFill
        return myVar
    }()
    
    private let infoContainerView: InfoDetailsContainerView = {
        let myVar = InfoDetailsContainerView()
        myVar.contentMode = .scaleToFill
        return myVar
    }()

    private let interItemSpacing: CGFloat = 10.0
    fileprivate let cellID = "cellID"
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = self.interItemSpacing
        let myVar = UICollectionView(frame: .zero, collectionViewLayout: layout)
        myVar.backgroundColor = UIColor.clear
        myVar.delegate = self
        myVar.dataSource = self
        myVar.isScrollEnabled = true
        myVar.register(UICollectionViewCell.self, forCellWithReuseIdentifier: self.cellID)
        return myVar
    }()
    
    
    // MARK: Set Up
    
    var collectionViewBottomConstraint: ConstraintItem?
    
    private func setUp() {
        
        topImageView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self)
            make.height.equalTo(self.snp.height).multipliedBy(0.4)
        }
        topImageView.darken(percent: 0.5)

        favoritesButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(topImageView.snp.centerY)
            make.width.height.equalTo(topImageView.snp.height).multipliedBy(0.2)
            make.leading.equalTo(topImageView.snp.leading).offset(Utils.shared.screenSize().width * 0.15)
        }
        
        chatButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(topImageView.snp.centerY)
            make.width.height.equalTo(topImageView.snp.height).multipliedBy(0.2)
            make.trailing.equalTo(topImageView.snp.trailing).offset(-Utils.shared.screenSize().width * 0.15)
        }
        
        infoContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(favoritesButton.snp.bottom).offset(15)
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(self.snp.height).multipliedBy(0.25)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(infoContainerView.snp.bottom).offset(15)
            make.leading.equalTo(infoContainerView.snp.leading)
            make.height.equalTo(self.snp.height).multipliedBy(0.15)
            make.trailing.equalTo(self.snp.trailing)
            
            collectionViewBottomConstraint = collectionView.snp.bottom
        }
    }
}


extension CellDetailsMainView: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellID, for: indexPath)
        
        cell.backgroundColor = UIColor.blue
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.size.width * 0.65, height: frame.size.height)
    }
    
}



