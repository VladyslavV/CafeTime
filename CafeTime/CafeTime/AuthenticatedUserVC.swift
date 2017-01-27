//
//  AuthenticatedUserVC.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 1/25/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseAuth

class AuthenticatedUserVC: UIViewController, AuthenticatedUserMainViewDelegate {
    
    private let mainView = AuthenticatedUserMainView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        
    }
    
    private func setUp() {
        self.view.addSubview(mainView)
        mainView.delegate = self
        mainView.snp.remakeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
    }
    
    //MARK: Main View Delegate
    
    func logOut() {
        AuthManager.shared.logOutUser()
        let nav = UINavigationController(rootViewController: LoginVC())
        self.present(nav, animated: true, completion: nil)
    }
}
