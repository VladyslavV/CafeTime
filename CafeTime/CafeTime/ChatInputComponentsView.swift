//
//  ChatInputComponentsView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/5/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import Foundation
import SnapKit


protocol ChatInputComponentsViewDelegate: class {
    func sendMessage(message: String)
}

class ChatInputComponentsView: UIView {
    
    weak var delegate: ChatInputComponentsViewDelegate?
    
    let sendButton : UIButton = {
        let myVar = UIButton(type: .system)
        myVar.setTitle(NSLocalizedString("chatvc.send.button", comment: ""), for: .normal)
        myVar.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        return myVar
    }()
    
    let inputTextField : UITextField = {
        let myVar = UITextField()
        myVar.placeholder = NSLocalizedString("chatvc.input.textfield", comment: "")
        myVar.textAlignment = .left
        myVar.backgroundColor = UIColor.lightGray
        return myVar
    }()
    
    let separatorLineView : UIView = {
        let myVar = UIView()
        myVar.backgroundColor = UIColor.black
        return myVar
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        self.addSubview(sendButton)
        self.addSubview(inputTextField)
        self.addSubview(separatorLineView)
        
        sendButton.snp.remakeConstraints { (make) in
            make.trailing.equalTo(self.snp.trailing)
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
            make.width.equalTo(self.snp.width).multipliedBy(0.2)
        }
        
        inputTextField.snp.remakeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(sendButton.snp.leading)
        }
        
        separatorLineView.snp.remakeConstraints { (make) in
            make.width.equalTo(self.snp.width)
            make.top.equalTo(self.snp.top)
            make.height.equalTo(self.snp.height).multipliedBy(0.01)
        }
    }
    
    // MARK: Actions
    @objc private func sendMessage() {
        if let text = inputTextField.text {
            self.delegate?.sendMessage(message: text)
        }
    }
    
}
