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

class AuthenticatedUserVC: UIViewController {

    private lazy var logOutButton : UIBarButtonItem = {
        let myVar = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action:  #selector(logOut))
        return myVar
    }()
    
    private let mainView = AuthenticatedUserMainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        self.navigationItem.rightBarButtonItem = self.logOutButton
    }

    private func setUp() {
        self.view.addSubview(mainView)
        mainView.snp.remakeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
    }
    
    @objc private func logOut() {
        if FIRAuth.auth()?.currentUser != nil {
            do {
                try FIRAuth.auth()?.signOut()
                self.dismiss(animated: true, completion: nil)
               // present(LoginAndSignUpVC(), animated: true, completion: nil)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    deinit {
        print("Auth VC Deallocced")
    }
}
