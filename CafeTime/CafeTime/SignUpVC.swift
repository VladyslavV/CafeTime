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

class SignUpVC: UIViewController, SignUpMainViewDelegate {


    private let mainView = SignUpMainView()
    
    override func viewDidLoad() {
        self.setUp()
        
    }
    
    private func setUp() {
        self.view.addSubview(mainView)
        mainView.delegate = self
        
        mainView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
    }
    
    //MARK: LoginMainView Delegate
    
    func signUpButtonPressed(vc: UIViewController) {
        self.present(vc, animated: true, completion: nil)
    }
    
}
