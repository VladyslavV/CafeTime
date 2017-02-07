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
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func presentInNav(vcs: [UIViewController]) {
        let nav = UINavigationController(rootViewController: vcs[1])
        vcs[0].present(nav, animated: true, completion: nil)
    }
}
