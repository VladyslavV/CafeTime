//
//  WhiteCellView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/17/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

enum CellState {
    case normal
    case deleting
    case editing
}

class ReusableCellContainerView: ReusableEmtpyCellContainer {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addSubviews([helpView, myImageView, titleLabel, detailLabel, rightImageView, deleteButton])
        self.setUpNormalState()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Vars
    
    var cellState: CellState = .normal {
        didSet {
            switch cellState {
            case .normal:
                self.setUpNormalState()
            case .deleting:
                self.setUpDeletingState()
            case .editing:
                self.setUpEditingState()
            }
        }
    }
    
    let deleteButton: UIButton = {
        let myVar = UIButton(type: .system)
        myVar.backgroundColor = UIColor.blue
        return myVar
    }()
    
    let helpView: UIImageView = {
        let myVar = UIImageView()
        myVar.backgroundColor = UIColor.clear
        return myVar
    }()
    
    
    let myImageView: UIImageView = {
        let myVar = UIImageView()
        myVar.backgroundColor = UIColor.green
        myVar.clipsToBounds = true
        myVar.contentMode = .scaleAspectFill
        return myVar
    }()
    
    let titleLabel: UILabel = {
        let myVar = UILabel()
        myVar.backgroundColor = UIColor.green
        myVar.adjustsFontSizeToFitWidth = true
        myVar.numberOfLines = 0
        return myVar
    }()
    
    let detailLabel: UILabel = {
        let myVar = UILabel()
        myVar.backgroundColor = UIColor.green
        myVar.font = UIFont.systemFont(ofSize: 14)
        myVar.numberOfLines = 0
        return myVar
    }()
    
    let rightImageView: UIImageView = {
        let myVar = UIImageView()
        myVar.backgroundColor = UIColor.green
        myVar.clipsToBounds = true
        myVar.contentMode = .scaleToFill
        return myVar
    }()
    
    
    // MARK: Set UP
    
    func setUpNormalState() {
        
        helpView.snp.makeConstraints { (make) in
            make.leading.equalTo(self.snp.leading).offset(10)
            make.height.width.equalTo(self.snp.height).multipliedBy(0.7)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        
        myImageView.snp.remakeConstraints { (make) in
            make.leading.equalTo(self.snp.leading).offset(10)
            make.height.width.equalTo(self.snp.height).multipliedBy(0.7)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        rightImageView.snp.remakeConstraints { (make) in
            make.trailing.equalTo(self.snp.trailing).offset(-10)
            make.height.equalTo(self.snp.height).multipliedBy(0.7)
            make.width.equalTo(self.snp.width).multipliedBy(0.05)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        titleLabel.snp.remakeConstraints { (make) in
            
            //help view
            make.top.equalTo(helpView.snp.top)
            
            make.height.equalTo(self.snp.height).multipliedBy(0.2)
            make.leading.equalTo(myImageView.snp.trailing).offset(10)
            make.trailing.lessThanOrEqualTo(rightImageView.snp.leading).offset(-3)
        }
        
        detailLabel.snp.remakeConstraints { (make) in
            
            //help view
            make.bottom.lessThanOrEqualTo(helpView.snp.bottom)
            
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(myImageView.snp.trailing).offset(10)
            make.trailing.lessThanOrEqualTo(rightImageView.snp.leading).offset(-3)
        }
        
        deleteButton.snp.remakeConstraints { (make) in
            make.leading.equalTo(self.snp.trailing).offset(100)
            make.centerY.equalTo(self.snp.centerY)
            make.height.width.equalTo(self.snp.height).multipliedBy(0.7)
        }
    }
    
    func setUpDeletingState() {
        
        myImageView.snp.remakeConstraints { (make) in
            make.trailing.equalTo(self.snp.leading).offset(-100)
            make.centerY.equalTo(self.snp.centerY)
            make.height.width.equalTo(self.snp.height).multipliedBy(0.7)
        }
        
        titleLabel.snp.remakeConstraints { (make) in
            
            //help view
            make.top.equalTo(helpView.snp.top)
            
            make.height.equalTo(self.snp.height).multipliedBy(0.2)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.trailing.lessThanOrEqualTo(rightImageView.snp.leading).offset(-3)
        }
        
        detailLabel.snp.remakeConstraints { (make) in
            
            //help view
            make.bottom.lessThanOrEqualTo(rightImageView.snp.bottom)
            
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.trailing.lessThanOrEqualTo(rightImageView.snp.leading).offset(-3)
        }
        
        deleteButton.snp.remakeConstraints { (make) in
            make.trailing.equalTo(self.snp.trailing).offset(-10)
            make.height.width.equalTo(self.snp.height).multipliedBy(0.6)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        rightImageView.snp.remakeConstraints { (make) in
            make.trailing.equalTo(deleteButton.snp.leading).offset(-10)
            make.height.equalTo(self.snp.height).multipliedBy(0.7)
            make.width.equalTo(self.snp.width).multipliedBy(0.05)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
    
    private func setUpEditingState() {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch self.cellState {
        case .normal:
            self.layer.cornerRadius = self.frame.size.width / 27
        case .deleting:
            self.layer.cornerRadius = 0
            self.roundCorners(corners: [.topRight, .bottomRight], radius: Double(self.frame.size.width / 27))
        case .editing:
            break
        }
        
        myImageView.layer.cornerRadius = myImageView.frame.size.width / 2
        deleteButton.layer.cornerRadius = deleteButton.frame.size.width / 2
    }
}
