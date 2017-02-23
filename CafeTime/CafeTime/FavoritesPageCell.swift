//
//  FavoritePagesCellView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/22/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

class FavoritesPageCell: UITableViewCell {

    
    // MARK: Init
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.lightGray
        self.selectionStyle = .none
        self.contentView.addSubview(containerView)
        self.setUpNormalStateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Vars
    
    public private(set) var id = UUID().uuidString
    
    let containerView = ReusableCellContainerView()
    
    var editingState: Bool = false {
        didSet {
            if editingState {
                self.setUpDeletingStateConstraints()
            }
            else {
                self.setUpNormalStateConstraints()
            }
        }
    }
    
    override func prepareForReuse() {
        self.setUpNormalStateConstraints()
    }
    
    // MARK: Set Up
    
    private func setUpNormalStateConstraints() {
        
        containerView.snp.remakeConstraints { (make) in
            make.edges.equalTo(self.contentView).inset(UIEdgeInsetsMake(10, 10, 10, 10))
            make.height.equalTo(Utils.shared.screenSize().height * 0.2)
        }
     
        containerView.cellState = .normal
        
        //self.animateConstraintsTransition(withDuration: 0.75)
    }
    
    private func setUpDeletingStateConstraints() {
        
        containerView.snp.remakeConstraints { (make) in
            make.edges.equalTo(self.contentView).inset(UIEdgeInsetsMake(10, 10, 10, 10))
            make.leading.equalTo(self.snp.leading)
            make.height.equalTo(Utils.shared.screenSize().height * 0.2)
        }
        
        containerView.cellState = .deleting
        
        self.animateConstraintsTransition(withDuration: 0.75)
    }

    
}
