//
//  ImageVC.swift
//  Demo2
//
//  Created by Vladysalv Vyshnevksyy on 1/18/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class ImageVC: UIViewController, UIGestureRecognizerDelegate, UIScrollViewDelegate {
    
    //MARK : Variables
    
    private var scrollView : UIScrollView = {
        let myVar = UIScrollView(frame: CGRect.zero)
        myVar.contentMode = UIViewContentMode.scaleAspectFit
        myVar.minimumZoomScale = 1.0
        myVar.maximumZoomScale = 3.0
        myVar.isUserInteractionEnabled = true
        myVar.backgroundColor = UIColor.clear
        return myVar
    }()
    
    private var myImageView : UIImageView  = {
        let myVar = UIImageView()
        myVar.layer.borderColor = UIColor.black.cgColor
        myVar.layer.borderWidth = 1.0
        myVar.isUserInteractionEnabled = true
        return myVar
    }()
    
    private lazy var doubleTapImageRecognizer : UITapGestureRecognizer = {
        let myVar = UITapGestureRecognizer()
        myVar.delegate = self
        myVar.numberOfTapsRequired = 2
        myVar.addTarget(self, action: #selector(imageDoubleTapped(_ :)))
        return myVar
    }()
    
    private lazy var tapGesture : UITapGestureRecognizer = {
        let myVar = UITapGestureRecognizer()
        myVar.delegate = self
        myVar.addTarget(self, action: #selector(tapped(_ :)))
        return myVar
    }()
    
    //MARK : Initialization
    
    init(imageURL: String) {
        myImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage.init(named: "placeholder"))
        super.init(nibName: nil, bundle: nil)
    }
    
    init(withImage image: UIImage) {
        myImageView.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.setUp()
    }
    
    // MARK: Constraints
    
    private func setUp() {
        self.view.addGestureRecognizer(self.tapGesture)
        
        scrollView.delegate = self
        scrollView.contentSize = (myImageView.image?.size)!
        scrollView.addSubview(myImageView)
        
        self.view.addSubview(self.scrollView)
        self.scrollView.addGestureRecognizer(self.doubleTapImageRecognizer)
        
        myImageView.snp.makeConstraints { (make) -> Void in
            make.edges.width.height.equalTo(scrollView)
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        if self.traitCollection.mk_matchesPhonePortrait() {
            scrollView.layer.cornerRadius  = scrollView.frame.size.width * 0.1
            myImageView.layer.cornerRadius = scrollView.frame.size.width * 0.1
        }
        else if self.traitCollection.mk_matchesPhoneLandscape() {
            scrollView.layer.cornerRadius  = scrollView.frame.size.height * 0.1
            myImageView.layer.cornerRadius = scrollView.frame.size.height * 0.1
        }
        scrollView.clipsToBounds = true
        myImageView.clipsToBounds = true
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {

        if self.traitCollection.mk_matchesPhonePortrait() {
            scrollView.snp.remakeConstraints { (make) -> Void in
                make.width.equalTo(self.view.snp.width)
                make.height.equalTo(self.view.snp.height).multipliedBy(0.5)
                make.centerY.equalTo(self.view.snp.centerY)
            }
            
        }
        else if self.traitCollection.mk_matchesPhoneLandscape() {
            scrollView.snp.remakeConstraints { (make) -> Void in
                make.height.equalTo(self.view.snp.height)
                make.width.equalTo(self.view.snp.width).multipliedBy(0.5)
                make.centerX.equalTo(self.view.snp.centerX)
            }
        }
    }
    
    // MARK: Actions
    
    func tapped(_ tap: UITapGestureRecognizer) {
        let touchPoint = tap.location(in: self.view)
        if scrollView.frame.contains(touchPoint) {
            return
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Scroll View
    
    func imageDoubleTapped(_ tap: UITapGestureRecognizer) {
        if (scrollView.zoomScale > scrollView.minimumZoomScale) {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        } else {
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        }
    }
    
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return myImageView;
    }
}
