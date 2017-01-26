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
    
    override func viewDidAppear(_ animated: Bool) {
        // log out if not authenticated
        print(FIRAuth.auth()?.currentUser?.uid ?? "");
        if FIRAuth.auth()?.currentUser?.uid == nil {
            self.logOut()
        }
    }
    
    //MARK: Main View Delegate
    
    func logOut() {
        if FIRAuth.auth()?.currentUser != nil {
            do {
                try FIRAuth.auth()?.signOut()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        let nav = UINavigationController(rootViewController: LoginVC())
        self.present(nav, animated: true, completion: nil)
    }
}
