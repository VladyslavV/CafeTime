//
//  ChatMessageCell.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/10/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

class ChatMessageCell: UICollectionViewCell {
    
    
    let textView: UITextView = {
        let myVar = UITextView()
        myVar.text = "Sample Text For Now"
        myVar.sizeToFit()
        myVar.font = UIFont.systemFont(ofSize: 16)
        return myVar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        
        backgroundColor = UIColor.red
        
        self.addSubview(textView)
        
        textView.snp.remakeConstraints { (make) in
            make.trailing.equalTo(self.snp.trailing)
            make.top.equalTo(self.snp.top)
           // make.width.equalTo(self.snp.width).multipliedBy(0.7)
            make.height.equalTo(self.snp.height)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
