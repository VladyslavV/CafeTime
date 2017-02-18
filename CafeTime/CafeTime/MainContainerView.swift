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
    
    // MARK: Constraints
    
    func setUpSelectedState() {
        
        detailContainerView.snp.remakeConstraints { (make) in
            make.top.equalTo(topContainerView.snp.bottom)
            make.leading.trailing.bottom.equalTo(self)
        }
    }
    
    func setUpDeselectedState() {
        
        detailContainerView.snp.remakeConstraints { (make) in
            make.width.height.equalTo(0)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.width / 27
        
        let height = self.frame.size.height
        topContainerView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self)
            make.height.equalTo(height - 10)
        }
    }
}
