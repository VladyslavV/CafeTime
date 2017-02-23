//
//  CommentsPageMainView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/23/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

class CommentsPageMainView: FavoritesPageMainView {

 
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Vars
    
    
    
    // MARK: Set Up

}

extension CommentsPageMainView {
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! FavoritesPageCell
        
        cell.containerView.titleLabel.text = "Comments"
        cell.containerView.detailLabel.text = "Some comments leaved by this particular customer for a specific restaurant"
        
        return cell
    }
}
