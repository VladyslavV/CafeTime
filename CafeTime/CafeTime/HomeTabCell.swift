//
//  HomeTabCell.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/15/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

class HomeTabCell: UITableViewCell {
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.cellSelected = false
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(mainContainerView)
        self.backgroundColor = UIColor.lightGray
        self.selectionStyle = .none
        self.setUp()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: States
    
    var cellSelected: Bool {
        didSet {
            if isSelected {
                self.mainContainerView.setUpSelectedState()
            } else {
                self.mainContainerView.setUpDeselectedState()
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected && self.cellSelected {
            self.isSelected = false
        }
        else if selected {
            self.cellSelected = true
        }
        else {
            self.cellSelected = false
        }
    }
    
    //MARK: Vars
    
    let mainContainerView: MainContainerView = {
        let myVar = MainContainerView()
        return myVar
    }()
    
    private func setUp() {
        mainContainerView.snp.remakeConstraints { (make) in
            make.edges.equalTo(self).inset(UIEdgeInsetsMake(10, 10, 10, 10))
        }
    }
}


