//
//  UIViewController+Extension.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/6/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

extension UIViewController {

    func presentAlert(message: String) {
        let alertController = UIAlertController(title: NSLocalizedString("vc.extenstion.allert", comment: ""), message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func presentInNav(vcs: [UIViewController]) {
        let nav = UINavigationController(rootViewController: vcs[1])
        vcs[0].present(nav, animated: true, completion: nil)
    }
    
    func presenetAlertWithCredentialFields(completion: @escaping (String,String) -> () ) {
        
        let alert = UIAlertController(title: "Enter Credentials", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Email"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textFieldEmail = alert?.textFields![0]
            let textFieldPassword = alert?.textFields![01]
            
            if let email = textFieldEmail?.text, let password = textFieldPassword?.text {
                completion(email, password)
            }
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
