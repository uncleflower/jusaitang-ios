//
//  LocationAdapter.swift
//  UWatChat
//
//  Created by Duona Zhou on 2018-01-12.
//  Copyright © 2018 Duona Zhou. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocationAdapter: NSObject{
    
    static let shared = LocationAdapter()
    
    typealias AuthorizationCompletionHandler = (CLAuthorizationStatus) -> Void
    
    typealias CoordinateCompletionHandler = (Double, Double) -> Void
    
    var completion:AuthorizationCompletionHandler?
    
    var coneCoordinateCompletion:CoordinateCompletionHandler?
    
    var coordinateCompletion:CoordinateCompletionHandler?
    
    var status:CLAuthorizationStatus?
    
    var locationManager:CLLocationManager?
    
    var latitude: Double = 0
    var longitude: Double = 0
    var city: String = ""
   
    func startUpdatingLocation(){
        locationManager?.startUpdatingLocation()
    }
    
    func stopUpdatingLocation(){
        locationManager?.stopUpdatingLocation()
    }
    
    func clear(){
        locationManager?.delegate = nil
        locationManager = nil
        stopUpdatingLocation()
    }
    
    
    func location(_ completion: @escaping((Double, Double)?, IError?) -> Void){
        LocationAdapter.shared.requestAuthorization { (status) in
            if status != .authorizedWhenInUse && status != .authorizedAlways{
                completion(nil, IError.init(code: .noLocation))
                return
            }
            
            LocationAdapter.shared.requestOnce { (latitude, longitude) in
                completion((latitude, longitude), nil)
            }
        }
    }
    
    func requestOnce(completion: @escaping CoordinateCompletionHandler){
        self.coordinateCompletion = completion
        self.startUpdatingLocation()
    }
    
    func requestAuthorization(completion: @escaping AuthorizationCompletionHandler){
        if locationManager == nil{
            locationManager = CLLocationManager.init()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        }
        locationManager?.delegate = self
        if let status = status{
            completion(status)
        }else{
            locationManager?.requestAlwaysAuthorization()
            self.completion = completion
        }
    }
    
    func city(latitude: Double, longitude: Double, _ completion: @escaping(String?) -> Void){
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude) // <- New York

        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages")
        UserDefaults.standard.set(NSArray.init(array: ["en"]), forKey: "AppleLanguages")
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, _) -> Void in
            UserDefaults.standard.set(appleLanguages, forKey: "AppleLanguages")
            placemarks?.forEach { (placemark) in
                if let city = placemark.locality {
                    completion(city)
                    return
                }
                completion(nil)
                return
            }
        })
    }
}

extension LocationAdapter:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        return
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coneCoordinateCompletion = self.coordinateCompletion, let coordinate = locations.last?.coordinate{
            coneCoordinateCompletion(coordinate.latitude, coordinate.longitude)
            self.coordinateCompletion = nil
        }
        return
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.status = status
        completion?(status)
        completion = nil
    }
}
