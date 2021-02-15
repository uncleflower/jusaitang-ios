//
//  MapView.swift
//  an-xin-bang
//
//  Created by Duona Zhou on 7/15/20.
//  Copyright © 2020 IdeThink Inc. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class MapView: UIView {
    let mapView:MKMapView = {
        let view = MKMapView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.mapView.delegate = self
        self.addSubview(mapView)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func makeConstraints(){
        self.mapView.snp.makeConstraints { (view) in
            view.edges.equalToSuperview()
        }
    }
    
    func move(latitude:Double, longitude: Double){
        let latDelta:Double = 0.05
        let longDelta:Double = 0.05
        let currentLocationSpan:MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: latDelta, longitudeDelta: longDelta)
        
        let center:CLLocation = CLLocation(latitude: latitude, longitude: longitude)
        let currentRegion:MKCoordinateRegion = MKCoordinateRegion(center: center.coordinate,
                                                                  span: currentLocationSpan)
        self.mapView.setRegion(currentRegion, animated: true)
        
    }
    
}

extension MapView: MKMapViewDelegate{
    
}
