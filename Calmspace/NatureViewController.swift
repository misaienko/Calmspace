//
//  NatureViewController.swift
//  Calmspace
//
//  Created by Admin on 30/10/2023.
//

import UIKit
import MapKit
import CoreLocation

class NatureViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
        
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.frame = view.bounds
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        print("Requesting location authorization")
        
        findNearbyPlaces(query: "Park")
        findNearbyPlaces(query: "Beach")
        findNearbyPlaces(query: "Mountains")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .denied:
            handleDeniedLocationPermission()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            break
        }
    }
    
    func handleDeniedLocationPermission() {
        print("User denied location permission")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user's location: \(error.localizedDescription)")
        
        let alertController = UIAlertController(
            title: "Location Error",
            message: "Failed to get your location. Please make sure location services are enabled.",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func findNearbyPlaces(query: String) {
        
            let updatedQuery = query == "Mountains" ? "Hiking trails" : query
            // Define the search request
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = query
            request.region = mapView.region

            // Create and perform the search
            let search = MKLocalSearch(request: request)
            search.start { response, error in
                guard let response = response else {
                    if let error = error {
                        print("Error searching for \(query)s: \(error.localizedDescription)")
                    }
                    return
                }

                if let firstItem = response.mapItems.first {
                    // Get the first result (which will be the closest)
                    let placemark = firstItem.placemark
                    self.displayPlaceOnMap(placemark: placemark)
                }
            }
        }
    func displayPlaceOnMap(placemark: MKPlacemark) {
            // Create a new annotation for the found place
            let annotation = MKPointAnnotation()
            annotation.coordinate = placemark.coordinate
            annotation.title = placemark.name

            // Add the annotation to the map
            mapView.addAnnotation(annotation)

            // Set the map's region to center on the found place
            let region = MKCoordinateRegion(center: placemark.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
            mapView.setRegion(region, animated: true)
        }
    

}
