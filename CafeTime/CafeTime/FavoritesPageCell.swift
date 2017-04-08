//
//  FavoritePagesCellView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/22/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

protocol FavoritesPageCellDelegate: class {
    func deleteCell(cell: FavoritesPageCell)
}

class FavoritesPageCell: UITableViewCell {
    
    // MARK: Init
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.lightGray
        self.selectionStyle = .none
        self.contentView.addSubview(containerView)
        self.setUpNormalStateConstraints()
        
        self.containerView.deleteButton.addTarget(self, action: #selector(deleteCell), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Vars
    
    weak var delegate: FavoritesPageCellDelegate?
    
    let containerView = ReusableCellContainerView()
    
    var editingState: (Bool,Bool) = (false, false) {
        didSet {
            if editingState.0 {
                
                self.setUpDeletingStateConstraints()
            }
            else {
                self.setUpNormalStateConstraints()
            }
            
            if editingState.1 {
                self.animateConstraintsTransition(withDuration: 0.75)
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
            make.height.equalTo(Utils.shared.screenSize().height * 0.2).priority(750)
        }
        
        containerView.cellState = .normal
    }
    
    private func setUpDeletingStateConstraints() {
        
        containerView.snp.remakeConstraints { (make) in
            make.edges.equalTo(self.contentView).inset(UIEdgeInsetsMake(10, 10, 10, 10))
            make.height.equalTo(Utils.shared.screenSize().height * 0.2).priority(750)
        }
        
        containerView.cellState = .deleting
    }
    
    // MARK: Actions
    
    @objc private func deleteCell() {
        self.delegate?.deleteCell(cell: self)
    }
}
