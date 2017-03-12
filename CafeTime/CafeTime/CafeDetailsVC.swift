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
        
        //pages vc
        self.addChildViewController(pagesContainerVC)
        self.view.addSubview(pagesContainerVC.view)
        pagesContainerVC.didMove(toParentViewController: self)
        
        self.setUp()
    }

    // MARK: Vars
    
    private let menuVC = CafeDetailsMenuVC()
    private let mapVC = CafeDetailsMapVC()
    private let bookVC = CafeDetailsBookVC()
    
    private lazy var vcsList: [Any] = {
        let dict = [["Menu" : self.menuVC], ["Map" : self.mapVC], ["Book" : self.bookVC]] as [Any]
        return dict
    }()
    
    private lazy var pagesContainerVC: ReusablePagesVC = {
        let myVar = ReusablePagesVC(vcsList: self.vcsList as! [[String : UIViewController]])
        myVar.titlesFont = UIFont.boldSystemFont(ofSize: 16)
        myVar.sliderHeight = 3
        myVar.menuBarHeightPercentOfViewsHeight = 0.3
        
        let imageArray = [UIImage(named: "sandwich"), UIImage(named: "sandwich"), UIImage(named: "sandwich")]
        myVar.iconImages = imageArray as? [UIImage]
        
        return myVar
    }()
    
    fileprivate lazy var mainView: CellDetailsMainView = {
        let myVar = CellDetailsMainView()
       // myVar.delegate = self
        return myVar
    }()
    
    // MARK: Set Up
        
    private func setUp() {

        self.navigationItem.title = "Restaurant"
        
        mainView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self.view)
            make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
        }
        
        pagesContainerVC.view.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(self.view)
            make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
            make.top.equalTo(self.mainView.collectionViewBottomConstraint!).offset(10)
        }
    }
    
    // MARK: Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navBar?.transparentNavigationBar()
    }
    

}

