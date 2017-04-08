//
//  FavoritesPageVC.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/18/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

class FavoritesPageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        self.view.addSubview(mainView)
        self.setUp()
    }

    private let mainView: FavoritesPageMainView = {
        let myVar = FavoritesPageMainView()
        myVar.translatesAutoresizingMaskIntoConstraints = false
        return myVar
    }()
        
    private func setUp() {
        mainView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
}
