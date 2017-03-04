//
//  CellDetailsMainView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/27/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

private class TopImageView: UIImageView {
    
    func darken() {
        
        let opacityView = UIView()
        opacityView.layer.backgroundColor = UIColor.black.cgColor
        opacityView.layer.opacity = 0.5
        
        self.addSubview(opacityView)

        opacityView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
}

class CellDetailsMainView: UIView {
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews([topImageView, infoContainerView])
        self.backgroundColor = UIColor.white
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Vars
    
    private lazy var topImageView: TopImageView = {
        let myVar = TopImageView()
        myVar.image = UIImage(named: "superSandwich")
        myVar.backgroundColor = UIColor.red
        myVar.contentMode = .scaleToFill
        return myVar
    }()
    
    private let infoContainerView: UIView = {
        let myVar = UIView()
        myVar.contentMode = .scaleToFill
        return myVar
    }()

    
    // MARK: Set Up
    
    private func setUp() {
        
        topImageView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self)
            make.height.equalTo(self.snp.height).multipliedBy(0.4)
        }
        topImageView.darken()

    }
    
 
}
