//
//  ReusableMenuCollectionView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/17/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

class ReusableMenuCollectionView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.collectionView)
        self.collectionView.addSubview(horizontalBar)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal var titlesArray = [String]()
    
    convenience init(withTitles titles: [String], andSliderAnimationDuration dur: TimeInterval) {
        self.init(frame: .zero)
        self.sliderAnimation = dur
        self.titlesArray = titles
    }
    
    // MARK: Vars
    
    internal var horizontalBar: UIView = {
        let myVar = UIView()
        myVar.backgroundColor = UIColor.green
        return myVar
    }()
    
    internal let cellID = "cell"
    internal var sliderAnimation: TimeInterval? = 0.5
    internal var padding: CGFloat = 10
    internal var constraintsInitializaed = false
    
    var itemWidth: CGFloat {
        return ((self.frame.width - 6 * padding) / CGFloat(titlesArray.count))
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, self.padding, 0, self.padding)
        let myVar = UICollectionView(frame: .zero, collectionViewLayout: layout)
        myVar.backgroundColor = UIColor.green
        myVar.delegate = self
        myVar.dataSource = self
        myVar.isScrollEnabled = false
        myVar.register(CustomMenuCollectionViewCell.self, forCellWithReuseIdentifier: self.cellID)
        return myVar
    }()
    
    private func setUp() {
        
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        let titleWidth = titlesArray[0].widthOfString(usingFont: UIFont.systemFont(ofSize: 14))
        horizontalBar.snp.remakeConstraints { (make) in
            make.width.equalTo(titleWidth)
            make.centerX.equalTo((itemWidth / 2) + padding)
            make.bottom.equalTo(self.snp.bottom)
            make.height.equalTo(self.snp.height).multipliedBy(0.03)
            
            constraintsInitializaed = true
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        horizontalBar.layer.cornerRadius = horizontalBar.frame.size.width / 35
        self.setUp()
    }
}

extension ReusableMenuCollectionView:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.titlesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CustomMenuCollectionViewCell
        
        cell.titleLabel.text = titlesArray[indexPath.row]
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if constraintsInitializaed {
            var x: CGFloat = 0
            if indexPath.row > 0 {
                x = CGFloat(indexPath.row) * (itemWidth + 2 * padding)
            }
            
            let titleWidth = titlesArray[indexPath.row].widthOfString(usingFont: UIFont.systemFont(ofSize: 14))
            horizontalBar.snp.remakeConstraints({ (make) in
                make.width.equalTo(titleWidth)
                make.centerX.equalTo(x + (itemWidth / 2) + padding)
                make.bottom.equalTo(self.snp.bottom)
                make.height.equalTo(5)
            })
        }
        
        UIView.animate(withDuration: sliderAnimation!, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemWidth, height: frame.height)
    }
    
}




















