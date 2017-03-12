//
//  CafeDetailsMenuVC.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 3/5/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

class CafeDetailsMenuVC: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(mainView)
        self.setUp()
    }
    
    fileprivate lazy var mainView: CafeDetailsMenuMainView = {
        let myVar = CafeDetailsMenuMainView()
        // myVar.delegate = self
        return myVar
    }()
    
    private func setUp() {
        
        mainView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
}
