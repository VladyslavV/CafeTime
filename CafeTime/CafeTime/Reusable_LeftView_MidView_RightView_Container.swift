//
//  DetailsPage_Image_Label_LabelContainer.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/21/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

class Reusable_LeftView_MidView_RightView_Container: ReusableEmtpyCellContainer {
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(view1: UIView, view2: UIView, view3: UIView) {
        self.init(frame: .zero)
        
        self.leftView = view1
        self.midView = view2
        self.rightView = view3
        
        if let view = leftView {
            self.addSubview(view)
        }
        
        if let view = midView {
            self.addSubview(view)
        }
        
        if let view = rightView {
            self.addSubview(view)
        }
        
        self.setUp()
    }
    
    // MARK: Vars
    
    var leftView: UIView?
    
    var midView: UIView?
    
    var rightView: UIView?
    
    // MARK: Set Up
    
    private func setUp() {
        
        if let view1 = leftView {
            view1.snp.remakeConstraints { (make) in
                make.leading.equalTo(self.snp.leading).offset(5)
                make.top.bottom.equalTo(self)
                make.width.equalTo(self.snp.width).multipliedBy(0.25)
            }
            
            if let view2 = midView {
                
                view2.snp.remakeConstraints { (make) in
                    make.leading.equalTo(view1.snp.trailing).offset(3)
                    make.width.equalTo(self.snp.width).multipliedBy(0.25)
                    make.top.bottom.equalTo(self)
                }
                
                if let view3 = rightView {
                    
                    view3.snp.remakeConstraints { (make) in
                        make.top.bottom.equalTo(self)
                        make.leading.equalTo(view2.snp.trailing).offset(5)
                        make.trailing.lessThanOrEqualTo(self.snp.trailing).offset(-3)
                    }
                }
            }
        }
    }
}
