//
//  ViewController.swift
//  Pennies to Pounds
//
//  Created by George McDonnell on 11/03/2016.
//  Copyright © 2016 George McDonnell. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    @IBOutlet weak var blurView: FXBlurView!
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        blurView.blurRadius = 5
        let layer = blurView.layer;
        layer.shadowOpacity = 0.5;
        layer.shadowColor = UIColor.whiteColor().CGColor
        layer.shadowOffset = CGSizeMake(0,0)
        layer.shadowRadius = 10
        
        locationManager.delegate = self
        // Set a movement threshold for new events.
        self.locationManager.distanceFilter = 50000 // meters

        checkLocationAuthorizationStatus()
    }
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func showLocation(location: CLLocation) {
        currentLocation = location
        let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 5000, 5000)
        mapView.setRegion(region, animated: false)
        
        addAnnotations()
    }
    
    func addAnnotations() {
        mapView.addAnnotations(annotations())
    }
    
    func annotations() -> [MKPointAnnotation] {
        let location1 = CLLocationCoordinate2DMake(51.515429, -0.141289)
        let location2 = CLLocationCoordinate2DMake(51.516429, -0.141289)
        let location3 = CLLocationCoordinate2DMake(51.515429, -0.142289)
        let location4 = CLLocationCoordinate2DMake(51.517429, -0.142289)

        let location5 = CLLocationCoordinate2DMake(51.541997, -0.107364)
        let location6 = CLLocationCoordinate2DMake(51.542997, -0.107364)
        let location7 = CLLocationCoordinate2DMake(51.541997, -0.108364)
        let location8 = CLLocationCoordinate2DMake(51.541997, -0.106364)
        
        let location9 = CLLocationCoordinate2DMake(51.522704, -0.109928)
        let location10 = CLLocationCoordinate2DMake(51.521704, -0.109928)
        let location11 = CLLocationCoordinate2DMake(51.523704, -0.108928)
        let location12 = CLLocationCoordinate2DMake(51.522704, -0.107928)
        
        let locations = [location1, location2, location3, location4, location5, location6, location7, location8, location9, location10, location11, location12]
        
        var annotations = [MKPointAnnotation]()
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotations.append(annotation)
        }
        
        return annotations
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        showLocation(locations.first!)
    }
}

extension ViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let annotation = TransactionAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        return annotation;
    }
}
