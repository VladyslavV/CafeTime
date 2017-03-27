//
//  CafeDetailsMenuViewModel.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 3/17/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

class MenuViewModel: NSObject, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCells.IDs.Primary, for: indexPath) as! PrimaryTableViewCell
        
        cell.contentView.backgroundColor = Colors.primaryGray
        cell.mainContainerView.topContainerView.titleLabel.text = "Title"
        cell.mainContainerView.topContainerView.detailLabel.text = "Many details will go here including lorem ipsum!!! details will go here including lorem ipsum details will go here including lorem ipsum will go here including lorem ipsum will go here including lorem ipsum will go here including lorem ipsum"

        
        return cell
    }
    
}
