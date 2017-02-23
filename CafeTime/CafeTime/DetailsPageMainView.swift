//
//  DetailsPageMainView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/20/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

class DetailsPageMainView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.addSubviews([topContainerView, btmContainerView])
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Vars
    private let topContainerView = DetailsPageTopContainerView()
    private let btmContainerView = DetailsPageBottomContainerView()

    // MARK: SetUp
    
    private func setUp() {
        
        topContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.trailing.equalTo(self.snp.trailing).offset(-10)
            make.height.equalTo(self.snp.height).multipliedBy(0.3)
        }
        
        btmContainerView.snp.makeConstraints { (make) in
            make.width.equalTo(topContainerView.snp.width)
            make.centerX.equalTo(topContainerView.snp.centerX)
            make.top.equalTo(topContainerView.snp.bottom).offset(10)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
        }
    }
}
