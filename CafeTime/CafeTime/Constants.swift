//
//  Remote_Dao_Strings.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/8/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

struct Constants {
    
    
    
    struct Remote {
        
        struct References {
            static let Cafes = "Cafes"
            static let Customers = "Customers"
            static let Connected = ".info/connected"
        }
        
        struct Values {
            static let UID = "uid"
        }

    }
    
    struct TableViewCells {
        
        struct IDs {
            static let Default = "DefaultCell"
            static let Primary = "CustomCell"
        }

        struct Size {
            static let NormalHeight = Utils.shared.screenSize().height * 0.2
            static let DetailsHeight = Utils.shared.screenSize().height * 0.4

        }
        
    }
    
}
