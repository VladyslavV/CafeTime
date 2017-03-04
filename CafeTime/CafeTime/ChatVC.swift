//
//  File.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/5/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import Foundation
import SnapKit

class ChatVC: BaseVC {
    
    // MARK: Vars
    private var userID: String!
    
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
        self.revealViewController().delegate = self
        self.setUp()
        self.setUpNavBar()
    }

    
    
    init(userID: String) {
        super.init(nibName: nil, bundle: nil)
        self.userID = userID
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(mainView)
        self.tabBarController?.tabBar.isHidden = true
        
        chatInputComponentsView.delegate = self
        
        
        mainView.snp.remakeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
        }
    }
    
    func setUpNavBar() {
        navBar?.topItem?.title = ""
        self.navigationItem.titleView = NavBarTitleView(withURLString: "http://ichef.bbci.co.uk/news/660/cpsprodpb/A2E4/production/_89400714_gettyimages-522829204.jpg", name: "Donald")
    }
  
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
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
