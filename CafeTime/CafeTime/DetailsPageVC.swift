//
//  DetailsPageVC.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/18/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

class DetailsPageVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(mainView)
    }
    
    private let mainView: DetailsPageMainView = {
        let myVar = DetailsPageMainView()
        return myVar
    }()
    
    // MARK: Set up
    
    private func setUp() {
        mainView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    override func viewDidLayoutSubviews() {
        self.setUp()
    }
    
    
}
