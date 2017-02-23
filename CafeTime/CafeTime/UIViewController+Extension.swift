//
//  UIViewController+Extension.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/6/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

extension UIViewController: SWRevealViewControllerDelegate {
    
    public func revealController(_ revealController: SWRevealViewController!, willMoveTo position: FrontViewPosition) {
        
        switch position {
            
        case FrontViewPosition.right:
            self.view.isUserInteractionEnabled = false
        default:
            self.view.isUserInteractionEnabled = true
        }
    }
}

extension UIViewController {
    
    // error
    func presentAlert(message: String) {
        let alertController = UIAlertController(title: NSLocalizedString("allert.title.error", comment: ""), message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: NSLocalizedString("allert.button.ok", comment: ""), style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }

    func presentInNav(vcs: [UIViewController]) {
        let nav = UINavigationController(rootViewController: vcs[1])
        vcs[0].present(nav, animated: true, completion: nil)
    }
    
    // enter credentials
    func presenetAlertWithCredentialFields(completion: @escaping (String,String) -> () ) {
        
        let alert = UIAlertController(title: NSLocalizedString("allert.enter.credentials", comment: ""), message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = NSLocalizedString("allert.email.textfield", comment: "")
        }
        alert.addTextField { (textField) in
            textField.placeholder = NSLocalizedString("allert.password.textfield", comment: "")
            textField.isSecureTextEntry = true
        }
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("allert.button.ok", comment: ""), style: .default, handler: { [weak alert] (_) in
            let textFieldEmail = alert?.textFields![0]
            let textFieldPassword = alert?.textFields![01]
            
            if let email = textFieldEmail?.text, let password = textFieldPassword?.text {
                completion(email, password)
            }
        }))

        alert.addAction(UIAlertAction(title: NSLocalizedString("allert.button.cancel", comment: ""), style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
