//
//  ChatMainView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/5/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import Foundation
import SnapKit

class ChatMainView: UIView {
    

    lazy var chatInputComponentsView : ChatInputComponentsView = {
        let myVar = ChatInputComponentsView()
        return myVar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Set Up
    
    private func setUp() {
        self.addSubview(chatInputComponentsView)
    
        chatInputComponentsView.backgroundColor = UIColor.red
        self.setUpConstraints()
    }
    
    private func setUpConstraints() {
        
        chatInputComponentsView.snp.remakeConstraints { (make) in
            make.bottom.equalTo(self.snp.bottom)
            make.width.equalTo(self.snp.width)
            make.height.equalTo(self.snp.height).multipliedBy(0.1)
        }
    }
    
}
