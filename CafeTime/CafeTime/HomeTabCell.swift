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
        showingDetails = false
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(mainContainerView)
        self.backgroundColor = UIColor.lightGray
        self.selectionStyle = .none
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Vars
    private let normalHeight = Utils.shared.screenSize().height * 0.2
    private let detailsHeight = Utils.shared.screenSize().height * 0.4
    
    var showingDetails: Bool {
        didSet {
            if showingDetails {
                installDetailsConstraints()
                mainContainerView.showDetails()
            }
            else {
                installNormalConstraints()
                mainContainerView.showNormalState()
            }
        }
    }
    
    override func prepareForReuse() {
        self.showingDetails = false
    }
    
    //MARK: Vars
    
    lazy var mainContainerView: MainContainerView = {
        let myVar = MainContainerView(topH: self.normalHeight, btmH: self.detailsHeight - self.normalHeight)
        return myVar
    }()
    
    private func setUp() {
        installNormalConstraints()
    }
    
    private func installNormalConstraints() {
        
        mainContainerView.snp.remakeConstraints { (make) in
            make.edges.equalTo(self.contentView).inset(UIEdgeInsetsMake(10, 10, 10, 10))
            make.height.equalTo(normalHeight)
        }
    }
    
    private func installDetailsConstraints() {
        
        mainContainerView.snp.remakeConstraints { (make) in
            make.edges.equalTo(self.contentView).inset(UIEdgeInsetsMake(10, 10, 10, 10))
            make.height.equalTo(detailsHeight)
        }
    }
    
    
}


