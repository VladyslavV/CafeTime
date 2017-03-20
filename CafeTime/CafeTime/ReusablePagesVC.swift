//
//  PagesContainerVC.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/20/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

class ReusablePagesVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        self.view.addSubview(mainView)
        self.setUp()
    }
    
    init(vcsList list: [[String : UIViewController]]) {
        self.vcsList = list
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Public
    
    var iconImages: [UIImage]? {
        didSet {
            self.mainView.menuBar.iconImages = (self.vcsList.count == iconImages?.count) ? iconImages : nil
        }
    }
    
    var sliderCornerRadiusPercentOfWidth: CGFloat = 0.03 {
        didSet{
            self.mainView.menuBar.sliderCornerRadiusPercentOfWidth = sliderCornerRadiusPercentOfWidth
        }
    }

    var sliderAnimation: TimeInterval? = 0.75 {
        didSet {
            self.mainView.menuBar.sliderAnimation = sliderAnimation
        }
    }
    
    var sliderColor: UIColor? = nil {
        didSet {
            self.mainView.menuBar.sliderColor = sliderColor
        }
    }
    
    var sliderHeight: CGFloat = 3 {
        didSet {
            self.mainView.menuBar.sliderHeight = sliderHeight
        }
    }
    
    var titlesFont: UIFont = UIFont.systemFont(ofSize: 14) {
        didSet {
            self.mainView.menuBar.titlesFont = titlesFont
        }
    }
    
    var titlesTextColor: UIColor = UIColor.white {
        didSet {
            self.mainView.menuBar.titlesTextColor = titlesTextColor
        }
    }
    
    var menuBarHeight: CGFloat = 30 {
        didSet {
            self.mainView.menuBarHeight = menuBarHeight
        }
    }
    
    // MARK: Vars
    fileprivate lazy var mainView: ReusablePagesMainView = {
        let titles = Array<Any>.arrayOfKeysFromListOfDictionaries(list: self.vcsList)
        let vcsArray: [UIViewController] = Array<Any>.arrayOfValuesFromListOfDictionaries(list: self.vcsList) as! [UIViewController]
        
        var views = [UIView]()
        
        for vc in vcsArray {
            // 1 add vcs
            self.addChildViewController(vc)
            //vc.didMove(toParentViewController: self)
            views.append(vc.view)
        }
        
        // 2 manage vc's view
        let myVar = ReusablePagesMainView(titles: titles, views: views)
        
        // 3 notify children
        for vc in vcsArray {
            vc.didMove(toParentViewController: self)
        }
        
        return myVar
    }()
    
    // MARK: Set up
    
    private func setUp() {
        mainView.snp.makeConstraints { (make) in
           make.edges.equalTo(self.view)
        }
    }
    
    // MARK: Vars
    private var vcsList: [[String : UIViewController]]!
    
}
