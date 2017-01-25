//
//  LoginVC.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 1/25/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import FirebaseAuth

class LoginAndSignUpVC: UIViewController, LoginAndSignUpMainViewDelegate {
    
    private var mainView = LoginAndSignUpMainView()
    
    override func viewDidLoad() {
        self.setUp()
    }
    
    private func setUp() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(mainView)
        mainView.delegate = self
        
        mainView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
    }
    
    //MARK: LoginMainView Delegate
    
    func loginOrsignUpButtonPressed(vc: UIViewController) {
        let nav = UINavigationController()
        nav.pushViewController(vc, animated: true)
        self.present(nav, animated: true, completion: nil)
    }
    

    
    
}
