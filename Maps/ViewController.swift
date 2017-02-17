//
//  ViewController.swift
//  Maps
//
//  Created by Saqlain-PC on 2/16/17.
//  Copyright © 2017 Saqlain-PC. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class ViewController: UIViewController, GMSAutocompleteViewControllerDelegate {
    
    
    @IBAction func btnSetup(_ sender: Any) {
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
        
    }
 

    
    var locationManager : CLLocationManager?
    var placesClient : GMSPlacesClient?
    var googleMapView : GMSMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager?.requestAlwaysAuthorization()
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 8.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
       
        // Creates a marker in the center of the map.
        
        //googleMapView?.isMyLocationEnabled = true
        //self.locationManager?.startUpdatingLocation()
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Sydney, Australia"
        marker.map = self.view as! GMSMapView?
        self.navigationItem.title = "Sydney"
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
 
    
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")

        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 8.0)
        self.view = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        let marker = GMSMarker()
        marker.position = place.coordinate
        marker.title = place.name
        marker.snippet = place.formattedAddress
        marker.map = self.view as! GMSMapView?
        self.navigationItem.title = place.name
        

        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    

    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    
}

