//
//  UITableView+Extensions.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/22/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import Foundation

extension UITableView {
    
    
    func tapInCell(recognizer: UITapGestureRecognizer, completion: (_ indexPath: IndexPath, _ tapLocation: CGPoint) -> () ) {
        
        if recognizer.state == UIGestureRecognizerState.ended {
            let tapLocation = recognizer.location(in: self)
            if let tapIndexPath = self.indexPathForRow(at: tapLocation) {
                if self.cellForRow(at: tapIndexPath) != nil {
                    completion(tapIndexPath, tapLocation)
                }
            }
        }
    }
}
