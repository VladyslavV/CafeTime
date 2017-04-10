//
//  CellDetailsMainView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/27/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

class CellDetailsHeaderView: UITableViewHeaderFooterView {
    
    // MARK: Init
    var view: UIImageView!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.addSubviews([topView, grayView, favoritesButton, chatButton, bookingsButton, infoContainerView, collectionView, menuBar])
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.reloadData()
    }
    
    
    // MARK: Vars
    
    lazy var menuBar: ReusableMenuCollectionView = {
        let myVar = ReusableMenuCollectionView(withTitles: ["Menu", "Map", "Book"])
        myVar.titlesTextColor = Colors.black
        myVar.titlesFont = UIFont.systemFont(ofSize: 14)
        myVar.sliderHeight = 3
        let imageArray = [UIImage(named: "icon-menu"), UIImage(named: "icon-map"), UIImage(named: "icon-send")]
        myVar.iconImages = imageArray as? [UIImage]
        return myVar
    }()
    
    
    private let topView: UIView = {
        let myVar = UIView()
        // myVar.backgroundColor = UIColor.red
        return myVar
    }()
    
    private let grayView: UIView = {
        let myVar = UIView()
        myVar.backgroundColor = Colors.primaryGray
        return myVar
    }()
    
    private let chatButton: UIButton = {
        let myVar = UIButton()
        myVar.contentMode = .scaleAspectFit
        myVar.setImage(UIImage(named: "icon-text")?.withRenderingMode(.alwaysTemplate), for: .normal)
        myVar.tintColor = UIColor.white
        return myVar
    }()
    
    private let bookingsButton: UIButton = {
        let myVar = UIButton(type: .system)
        myVar.contentMode = .scaleAspectFit
        myVar.setImage(UIImage(named: "icon-pipl-rest")?.withRenderingMode(.alwaysTemplate), for: .normal)
        myVar.tintColor = Colors.darkYellow
        return myVar
    }()
    
    private let favoritesButton: UIButton = {
        let myVar = UIButton()
        myVar.contentMode = .scaleAspectFit
        myVar.setImage(UIImage(named: "icon-favorite")?.withRenderingMode(.alwaysTemplate), for: .normal)
         myVar.tintColor = Colors.primaryGreen
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
    func updateGrayViewConstraints() {
        
        let vc = parentViewController!
        let navBarHeight = vc.navigationController?.navigationBar.frame.size.height
        topView.snp.makeConstraints { (make) in
            if let h = navBarHeight {
                make.top.equalTo(self.snp.top).offset(-h)
                make.trailing.leading.equalTo(self)
                make.height.equalTo(self.superview!.snp.height).multipliedBy(0.4)
            }
        }
        
        grayView.snp.remakeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.leading.trailing.bottom.equalTo(self)
        }
    }
    
    private func setUp() {
        
        self.contentView.snp.makeConstraints { (make) in
            make.bottom.top.leading.trailing.equalTo(self)
        }
        
        let screenWidth = Utils.shared.screenSize().width
        let screenHeight = Utils.shared.screenSize().height
        
        grayView.snp.makeConstraints { (make) in
            make.height.equalTo(screenHeight * 0.6)
            make.leading.trailing.bottom.equalTo(self)
        }
        
        favoritesButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top).offset(100)
            make.leading.equalTo(self.snp.leading).offset(screenWidth * 0.1)
            make.width.height.equalTo(screenWidth * 0.15)
        }
        
        bookingsButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(favoritesButton.snp.top).offset(-10)
            make.height.width.equalTo(screenWidth * 0.18)
        }
        
        chatButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top).offset(100)
            make.width.height.equalTo(screenWidth * 0.15)
            make.trailing.equalTo(self.snp.trailing).offset(-(screenWidth * 0.1))
        }
        
        infoContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(favoritesButton.snp.bottom).offset(15)
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(screenHeight * 0.25)
            make.centerX.equalTo(self.contentView.snp.centerX).priority(750)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(infoContainerView.snp.bottom).offset(15).priority(750)
            make.leading.equalTo(infoContainerView.snp.leading)
            make.height.equalTo(screenHeight * 0.2)
            make.trailing.equalTo(self.snp.trailing)
        }
        
        menuBar.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom).offset(15)
            make.width.equalTo(self.snp.width)
            make.height.equalTo(screenHeight * 0.1)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-10)
        }
    }
}

extension CellDetailsHeaderView: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellID, for: indexPath)
        
        cell.backgroundColor = UIColor.blue
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width * 0.65, height: self.collectionView.frame.size.height)
    }
    
}



