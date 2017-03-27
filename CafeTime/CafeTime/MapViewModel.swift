//
//  CafeDetailsMapViewModel.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 3/17/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SnapKit
import MapKit

class MapViewModel: NSObject, UITableViewDataSource {

    var mapView: MKMapView = {
        let myVar = MKMapView()
        myVar.mapType = .standard
        myVar.isZoomEnabled = true
        myVar.isScrollEnabled = true
        myVar.clipsToBounds = true
        return myVar
    }()
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "")
        cell.selectionStyle = .none
        
        cell.contentView.snp.remakeConstraints { (make) in
            make.leading.trailing.top.equalTo(cell)
            make.height.equalTo(200)
        }
        
        cell.contentView.backgroundColor = Colors.primaryGray
        cell.contentView.addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.edges.equalTo(cell.contentView).inset(UIEdgeInsetsMake(10, 10, 10, 10))
       }
       

        mapView.layer.cornerRadius = cell.contentView.frame.width * 0.1
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
}
