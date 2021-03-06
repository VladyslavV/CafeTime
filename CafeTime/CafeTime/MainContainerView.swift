//
//  MainContainerView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/16/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

class MainContainerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addSubviews([topContainerView, detailContainerView])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Vars
    
    let topContainerView: CellTopDetailsContainerView = {
        let myVar = CellTopDetailsContainerView()
        myVar.backgroundColor = UIColor.white
        return myVar
    }()
    
    let detailContainerView: CellBottomDetailsContainerView = {
        let myVar = CellBottomDetailsContainerView()
        myVar.backgroundColor = UIColor.white
        return myVar
    }()
    
    private var topContainerHeight: CGFloat!
    private var btmContainerHeight: CGFloat!
    
    convenience init(topH: CGFloat, btmH: CGFloat) {
        self.init(frame: .zero)
        self.topContainerHeight = topH
        self.btmContainerHeight = btmH
        self.showNormalState()
    }
    
    // MARK: Constraints
    
    func showDetails() {
        
        self.addSubview(detailContainerView)
        
        detailContainerView.snp.remakeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(topContainerHeight)
            make.leading.trailing.equalTo(self)
            make.height.equalTo(btmContainerHeight)
        }
    }
    
    func showNormalState() {
        
        topContainerView.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalTo(self)
            make.height.equalTo(topContainerHeight)
        }
        
        detailContainerView.removeFromSuperview()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.width / 27
    }
}
