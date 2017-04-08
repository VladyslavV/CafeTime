//
//  CommentsPageVC.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/18/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit

class CommentsPageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(mainView)
        self.setUp()
    }

    private let mainView: CommentsPageMainView = {
        let myVar = CommentsPageMainView()
        myVar.translatesAutoresizingMaskIntoConstraints = false
        return myVar
    }()
    
    private func setUp() {
        
        mainView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
}
