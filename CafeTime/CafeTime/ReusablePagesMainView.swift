//
//  PagesContainerMainView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/20/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

class ReusablePagesMainView: UIView {
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal var numberOfElements: Int!
    convenience init(titles: [String], views: [UIView]) {
        self.init(frame: .zero)
        self.numberOfElements = titles.count
        self.menuBar = ReusableMenuCollectionView(withTitles: titles)
        self.menuBar.delegate = self
        self.views = views
        self.addSubviews([menuBar, collectionView])
        self.setUp()
    }
    
    // MARK: Vars
    internal let cellID = "cell"
    internal var views: [UIView]!
    internal var menuBar: ReusableMenuCollectionView!
    
    internal lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        //layout.sectionInset = UIEdgeInsetsMake(0, self.padding, 0, self.padding)
        let myVar = UICollectionView(frame: .zero, collectionViewLayout: layout)
        myVar.backgroundColor = UIColor.clear
        myVar.delegate = self
        myVar.dataSource = self
        myVar.isPagingEnabled = true
        myVar.register(UICollectionViewCell.self, forCellWithReuseIdentifier: self.cellID)
        return myVar
    }()
    
    private var menuBarPercentOfViewsHeightConstraint: Constraint?

    var menuBarHeight: CGFloat = 30 {
        didSet {
            menuBarPercentOfViewsHeightConstraint?.deactivate()
            menuBar.snp.updateConstraints { (make) in
                menuBarPercentOfViewsHeightConstraint = make.height.equalTo(menuBarHeight).constraint
                menuBarPercentOfViewsHeightConstraint?.activate()
            }
        }
    }
    
    
    // MARK: Set Up

    private func setUp() {
        
        collectionView.backgroundColor = UIColor.clear
        
        menuBar.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalTo(self)
            menuBarPercentOfViewsHeightConstraint = make.height.equalTo(menuBarHeight).constraint
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(menuBar.snp.bottom).offset(10)
            make.bottom.leading.trailing.equalTo(self)
        }
    }
}

extension ReusablePagesMainView: ReusableMenuCollectionViewDelegate {
    
    func pageSelectedAtRow(row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
    }
}

extension ReusablePagesMainView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfElements
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellID, for: indexPath)
        
        let vcView = self.views[indexPath.row]
        
        cell.contentView.addSubview(vcView)
        
        vcView.snp.remakeConstraints { (make) in
            make.edges.equalTo(cell.contentView)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width, height: self.collectionView.frame.size.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.scrollSliderBy(x: scrollView.contentOffset.x / CGFloat(numberOfElements))
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.bounds.size.width;
        menuBar.setSliderWidthAtRow(row: Int(pageNumber))
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.bounds.size.width;
        menuBar.setSliderWidthAtRow(row: Int(pageNumber))
    }
}
