//
//  ViewController.swift
//  Pennies to Pounds
//
//  Created by George McDonnell on 11/03/2016.
//  Copyright © 2016 George McDonnell. All rights reserved.
//

import UIKit
import MapKit
import TKSubmitTransition

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var currentTransitionButton: TKTransitionSubmitButton?
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var blurView: FXBlurView!
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let logo = UIImage(named: "Coins")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        locationManager.delegate = self
        // Set a movement threshold for new events.
        self.locationManager.distanceFilter = 50000 // meters

        checkLocationAuthorizationStatus()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateMap:", name: "updateMap", object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        blurView.blurRadius = 5
        blurView.layer.cornerRadius = 5
        blurView.layer.masksToBounds = false;
        blurView.layer.shadowColor = UIColor.whiteColor().CGColor
        blurView.layer.backgroundColor = blurView.layer.shadowColor;
        blurView.layer.shadowPath = UIBezierPath(roundedRect: CGRectMake(-2.0*5, -2.0*5, blurView.bounds.size.width+4.0*5, blurView.bounds.size.height+4.0*5), cornerRadius: 5).CGPath
        
        blurView.layer.cornerRadius = 5;
        blurView.layer.shadowOffset = CGSizeMake(0.0, 0.0);
        blurView.layer.shadowRadius = 5;
        blurView.layer.shadowOpacity = 0.5;
        blurView.layer.opacity = 1.0;
    }
    
    @IBAction func updateMap(notification: NSNotification) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = currentLocation!.coordinate
        
        mapView.addAnnotation(annotation)
        button.hidden = true
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
        
        let offsetLocation = CLLocation(latitude: currentLocation!.coordinate.latitude + 0.012, longitude: currentLocation!.coordinate.longitude - 0.01)
        let region = MKCoordinateRegionMakeWithDistance(offsetLocation.coordinate, 5000, 5000)
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

extension ViewController: MKMapViewDelegate, UIViewControllerTransitioningDelegate {
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let distanceThreshold: CLLocationDistance = 2.0
        if currentLocation!.distanceFromLocation(CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)) < distanceThreshold {
            let annotationView = NewTransactionAnnotationView(annotation: annotation, reuseIdentifier: nil)
            return annotationView
        } else {
            let annotationView = TransactionAnnotationView(annotation: annotation, reuseIdentifier: nil)
            return annotationView
        }

    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        if (view.isKindOfClass(NewTransactionAnnotationView)) {
            currentTransitionButton = (view as! NewTransactionAnnotationView).transitionButton
            currentTransitionButton!.startLoadingAnimation()
            performSelector("finishTransition", withObject: nil, afterDelay: 1.0)
        }
    }
    
    func finishTransition() {
        currentTransitionButton?.startFinishAnimation(0, completion: { () -> () in
            let secondVC = self.storyboard?.instantiateViewControllerWithIdentifier("NewTransaction") as! NewTransactionViewController
            secondVC.transitioningDelegate = self
            self.presentViewController(secondVC, animated: true, completion: nil)
        })
    }
    
    
    // MARK: UIViewControllerTransitioningDelegate
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let fadeInAnimator = TKFadeInAnimator()
        return fadeInAnimator
    }
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}
