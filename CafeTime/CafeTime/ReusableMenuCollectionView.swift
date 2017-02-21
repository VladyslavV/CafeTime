//
//  ReusableMenuCollectionView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/17/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

protocol ReusableMenuCollectionViewDelegate: class {
    func pageSelectedAtRow(row: Int)
}

class ReusableMenuCollectionView: UIView {
    
    weak var delegate: ReusableMenuCollectionViewDelegate?
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.collectionView)
        self.collectionView.addSubview(slider)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate var titlesArray = [String]()
    
    convenience init(withTitles titles: [String]) {
        self.init(frame: .zero)
        self.titlesArray = titles
    }
    
    // MARK: Vars
    
    
    // MARK: Public API
    var sliderCornerRadiusPercentOfWidth: CGFloat = 0.03
    var sliderAnimation: TimeInterval? = 0.75
    var sliderColor: UIColor? = nil {
        didSet {
            self.slider.backgroundColor = sliderColor
        }
    }
    var sliderHeight: CGFloat = 3
    
    var titlesFont: UIFont = UIFont.systemFont(ofSize: 14) {
        didSet {
            self.setNeedsLayout()
            self.collectionView.reloadData()
        }
    }
    
    var titlesTextColor: UIColor = UIColor.white {
        didSet {
            self.setNeedsLayout()
            self.collectionView.reloadData()
        }
    }
    
    
    // MAKR: FilePrivate
    fileprivate let cellID = "cell"
    
    fileprivate var interItemSpacing: CGFloat = 10
    
    fileprivate var slider: UIView = {
        let myVar = UIView()
        myVar.backgroundColor = UIColor.green
        return myVar
    }()
    
    fileprivate var itemWidth: CGFloat {
        return ((self.frame.width - (CGFloat(titlesArray.count) * 2) * interItemSpacing) / CGFloat(titlesArray.count))
    }
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = self.interItemSpacing
        //layout.sectionInset = UIEdgeInsetsMake(0, self.padding, 0, self.padding)
        let myVar = UICollectionView(frame: .zero, collectionViewLayout: layout)
        myVar.backgroundColor = UIColor.clear
        myVar.delegate = self
        myVar.dataSource = self
        myVar.isScrollEnabled = false
        myVar.register(SegmentedMenuCollectionViewCell.self, forCellWithReuseIdentifier: self.cellID)
        return myVar
    }()
    
    // MARK: Set up
    
    private func setUp() {
        
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        let titleWidth = titlesArray[0].widthOfString(usingFont: self.titlesFont)
        self.updateSliderConstraints(width: titleWidth, centerX: (itemWidth / 2 - titleWidth / 2) + titleWidth / 2 )
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setUp()
        slider.layer.cornerRadius = slider.frame.size.width * sliderCornerRadiusPercentOfWidth
    }
}

extension ReusableMenuCollectionView:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.titlesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SegmentedMenuCollectionViewCell
        cell.titleLabel.text = titlesArray[indexPath.row]
        
        cell.titleLabel.font = titlesFont
        cell.titleLabel.textColor = titlesTextColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.pageSelectedAtRow(row: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemWidth, height: frame.height)
    }
    
    // MARK: Helper
    
    
    func scrollSliderBy(x: CGFloat) {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = self.collectionView.cellForItem(at: indexPath)
        
        if let width = cell?.frame.size.width {
            self.updateSliderConstraints(width: width, centerX: x + (itemWidth / 2) + interItemSpacing)
        }
    }
    
    func setSliderWidthAtRow(row: Int)  {
        let indexPath = IndexPath(row: row, section: 0)
        let cell = self.collectionView.cellForItem(at: indexPath) as! SegmentedMenuCollectionViewCell
        let font = cell.titleLabel.font
        let titleWidth = titlesArray[indexPath.row].widthOfString(usingFont: font!)
        
        self.updateSliderConstraints(width: titleWidth, centerX: cell.titleLabel)
    }
    
    private func animateConstraintsTransition() {
        UIView.animate(withDuration: sliderAnimation!, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    fileprivate func updateSliderConstraints(width: CGFloat, centerX: ConstraintRelatableTarget){
        
        slider.snp.remakeConstraints({ (make) in
            make.width.equalTo(width)
            make.centerX.equalTo(centerX)
            make.bottom.equalTo(self.snp.bottom)
            make.height.equalTo(sliderHeight)
        })
        self.animateConstraintsTransition()
    }
}




















