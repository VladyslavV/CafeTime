//
//  File.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/5/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import Foundation
import SnapKit

class ChatVC: UIViewController {
    
    // MARK: Vars
    
    private lazy var mainView: ChatMainView = {
        let myVar = ChatMainView()
        //myVar.delegate = self
        return myVar
    }()
    
    internal lazy var chatInputComponentsView: ChatInputComponentsView = {
        let myVar = self.mainView.chatInputComponentsView
        return myVar
    }()
    
    
    // MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }
    
    
    private func setUp() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(mainView)
        self.tabBarController?.tabBar.isHidden = true
        
        chatInputComponentsView.delegate = self
        
        self.navigationItem.title = "Chat"

        mainView.snp.remakeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
        }
    }
    
    deinit {
        print("object \( String(describing: (self))) dealloced")
    }
}

extension ChatVC: ChatInputComponentsViewDelegate {
    
    // MARK: Input components view Delegate
    
    func sendMessage(message: String) {
        print(message)
    }
}
