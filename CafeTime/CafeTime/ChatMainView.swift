//
//  ChatMainView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/5/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import Foundation
import SnapKit

class ChatMainView: UIView {
    
    lazy var chatInputComponentsView : ChatInputComponentsView = {
        let myVar = ChatInputComponentsView()
        return myVar
    }()
    
    internal let cellID = "cell"
    lazy var collectionView : UICollectionView = {
        let myVar = UICollectionView(frame: CGRect.zero, collectionViewLayout:  UICollectionViewFlowLayout())
        myVar.register(UICollectionViewCell.self, forCellWithReuseIdentifier: self.cellID)
        myVar.delegate = self
        myVar.dataSource = self
        return myVar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Set Up
    
    private func setUp() {
        self.addSubview(chatInputComponentsView)
        self.addSubview(collectionView)
        
        collectionView.backgroundColor = UIColor.blue
        
        self.setUpConstraints()
    }
    
    private func setUpConstraints() {
        
        chatInputComponentsView.snp.remakeConstraints { (make) in
            make.bottom.equalTo(self.snp.bottom)
            make.width.equalTo(self.snp.width)
            make.height.equalTo(self.snp.height).multipliedBy(0.1)
        }
        
        collectionView.snp.remakeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.leading.trailing.equalTo(self)
            make.bottom.equalTo(chatInputComponentsView.snp.top)
        }
    }
}

extension ChatMainView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        cell.backgroundColor = UIColor.red
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5

    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 60)
    }
}

