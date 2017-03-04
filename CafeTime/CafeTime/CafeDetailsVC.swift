//
//  CafeDetailsVC.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/27/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

class CafeDetailsVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(mainView)
        self.setUp()
    }

    // MARK: Vars
    
    fileprivate lazy var mainView: CellDetailsMainView = {
        let myVar = CellDetailsMainView()
       // myVar.delegate = self
        return myVar
    }()
    
    // MARK: Set Up
        
    private func setUp() {

        self.navigationItem.title = "Restaurant"
    
        self.revealViewController().delegate = self
        mainView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self.view)
            make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navBar?.transparentNavigationBar()
    }

}
