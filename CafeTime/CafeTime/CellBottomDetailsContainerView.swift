//
//  CellDetailsContainerView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/16/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

class CellBottomDetailsContainerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubviews([discountLabel, drinksImageView, saladImageView, sandwichImageView, dishesImageView, drinksLabel, saladLabel, sandwichLabel, dishesLabel])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Vars
    
    let discountLabel: UILabel = {
        let myVar = UILabel()
       // myVar.backgroundColor = UIColor.green
        myVar.text = "Dicsount on"
        return myVar
    }()
    
    let sandwichImageView: UIImageView = {
        let myVar = UIImageView()
        myVar.contentMode = .scaleToFill
        myVar.image = UIImage(named: "sandwich")
        //myVar.backgroundColor = UIColor.green
        return myVar
    }()
    
    let saladImageView: UIImageView = {
        let myVar = UIImageView()
        myVar.contentMode = .scaleToFill
        myVar.image = UIImage(named: "salad")
        //myVar.backgroundColor = UIColor.green
        return myVar
    }()
    
    let drinksImageView: UIImageView = {
        let myVar = UIImageView()
        myVar.contentMode = .scaleToFill
        myVar.image = UIImage(named: "cola")
        //myVar.backgroundColor = UIColor.green
        return myVar
    }()
    
    let dishesImageView: UIImageView = {
        let myVar = UIImageView()
        myVar.contentMode = .scaleToFill
        myVar.backgroundColor = UIColor.green
        return myVar
    }()
    
    let sandwichLabel: UILabel = {
        let myVar = UILabel()
        myVar.textAlignment = NSTextAlignment.center
        //myVar.backgroundColor = UIColor.green
        myVar.adjustsFontSizeToFitWidth = true
        myVar.text = "Sandwiches"
        return myVar
    }()
    
    let saladLabel: UILabel = {
        let myVar = UILabel()
        myVar.textAlignment = NSTextAlignment.center
        //myVar.backgroundColor = UIColor.green
        myVar.adjustsFontSizeToFitWidth = true
        myVar.text = "Salads"
        return myVar
    }()
    
    let drinksLabel: UILabel = {
        let myVar = UILabel()
        myVar.textAlignment = NSTextAlignment.center
       //myVar.backgroundColor = UIColor.green
        myVar.adjustsFontSizeToFitWidth = true
        myVar.text = "Drinks"
        return myVar
    }()
    
    let dishesLabel: UILabel = {
        let myVar = UILabel()
        myVar.textAlignment = NSTextAlignment.center
       // myVar.backgroundColor = UIColor.green
        myVar.adjustsFontSizeToFitWidth = true
        myVar.text = "Dishes"
        return myVar
    }()
    
    
    
    
    // MARK: constraints
    
    private func setUp() {
        
        if let containerWidth = superview?.frame.size.width, let containerHeight = superview?.frame.size.height {
            let totalDiscountedGoodsWidth = containerWidth * 0.2 * 4
            let spacing = (containerWidth - totalDiscountedGoodsWidth) / 4
          
            let topOffset = containerHeight * 0.05
            
            discountLabel.snp.remakeConstraints { (make) in
                make.top.equalTo(self.snp.top).offset(topOffset)
                make.trailing.equalTo(self.snp.trailing).offset(-10)
                make.height.equalTo(self.snp.height).multipliedBy(0.15)
            }
            
            //MARK: ImageViews
            drinksImageView.snp.remakeConstraints { (make) in
                make.top.equalTo(discountLabel.snp.bottom).offset(topOffset)
                make.leading.equalTo(self.snp.leading).offset(spacing / 2)
                make.height.equalTo(self.snp.height).multipliedBy(0.5)
                make.width.equalTo(self.snp.width).multipliedBy(0.2)
            }
            
            saladImageView.snp.remakeConstraints { (make) in
                make.top.equalTo(drinksImageView.snp.top)
                make.leading.equalTo(drinksImageView.snp.trailing).offset(spacing)
                make.height.width.equalTo(drinksImageView)
            }
            
            sandwichImageView.snp.remakeConstraints { (make) in
                make.top.equalTo(drinksImageView.snp.top)
                make.leading.equalTo(saladImageView.snp.trailing).offset(spacing)
                make.height.width.equalTo(drinksImageView)
            }
            
            dishesImageView.snp.remakeConstraints { (make) in
                make.top.equalTo(drinksImageView.snp.top)
                make.leading.equalTo(sandwichImageView.snp.trailing).offset(spacing)
                make.height.width.equalTo(drinksImageView)
            }
            
            //MARK: Labels
            drinksLabel.snp.remakeConstraints { (make) in
                make.top.equalTo(drinksImageView.snp.bottom).offset(topOffset)
                make.leading.trailing.equalTo(drinksImageView)
                make.bottom.equalTo(self.snp.bottom).offset(-2)
            }

            
            saladLabel.snp.remakeConstraints { (make) in
                make.top.equalTo(saladImageView.snp.bottom).offset(topOffset)
                make.leading.trailing.equalTo(saladImageView)
                make.bottom.equalTo(drinksLabel.snp.bottom).offset(-2)
            }
            
            sandwichLabel.snp.remakeConstraints { (make) in
                make.top.equalTo(sandwichImageView.snp.bottom).offset(topOffset)
                make.leading.trailing.equalTo(sandwichImageView)
                make.bottom.equalTo(self.snp.bottom).offset(-2)
            }
            
            dishesLabel.snp.remakeConstraints { (make) in
                make.top.equalTo(dishesImageView.snp.bottom).offset(topOffset)
                make.leading.trailing.equalTo(dishesImageView)
                make.bottom.equalTo(self.snp.bottom).offset(-2)
            }
        }
    }
       
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.width / 27
        self.setUp()
    }
}
