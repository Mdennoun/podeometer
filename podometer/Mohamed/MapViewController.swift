//
//  MapViewController.swift
//  podometer
//
//  Created by Mohamed dennoun on 27/01/2021.
//  Copyright © 2021 Mohamed dennoun. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    
    @IBOutlet weak var mapView: MKMapView!
    var userCoordinate: MKCoordinateRegion?
    let locationManager = CLLocationManager()
    var userLocation: CLLocationCoordinate2D?
    var userlocations = [CLLocationCoordinate2D]()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.navigationItem.title = "Carte"
            self.locationManager.requestAlwaysAuthorization()

            // For use in foreground
            self.locationManager.requestWhenInUseAuthorization()

            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.startUpdatingLocation()
            }

            self.mapView.delegate = self
            self.mapView.mapType = .standard
            self.mapView.isZoomEnabled = true
            self.mapView.isScrollEnabled = true

                   if let coor = self.mapView.userLocation.location?.coordinate{
                      
                       
                       self.mapView.setCenter(coor, animated: true)
                      
                   }
            
            //let sourceLocation = CLLocationCoordinate2D(latitude: 28.704060, longitude: 77.102493)
            //let intermediateLocation = CLLocationCoordinate2D(latitude: 28.5, longitude: 77.026634)
            //let destinationLocation = CLLocationCoordinate2D(latitude: 28.459497, longitude: 77.026634)
            
           // createPath(sourceLocation: sourceLocation, destinationLocation: intermediateLocation)
           // createPath(sourceLocation: intermediateLocation, destinationLocation: destinationLocation)
            
            self.mapView.delegate = self
        }
     
        func drawMapPoint(location : CLLocationCoordinate2D) {
            let sourcePlaceMark = MKPlacemark(coordinate: location, addressDictionary: nil)
           
            
            let sourceMapItem = MKMapItem(placemark: sourcePlaceMark)
            
            
            
            let directionRequest = MKDirections.Request()
            directionRequest.source = sourceMapItem
            directionRequest.destination = sourceMapItem
            directionRequest.transportType = .walking
            
            let direction = MKDirections(request: directionRequest)
            
            
            direction.calculate { (response, error) in
                guard let response = response else {
                    if let error = error {
                        print("ERROR FOUND : \(error.localizedDescription)")
                    }
                    return
                }
                
                let route = response.routes[0]
                self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
                
                let rect = route.polyline.boundingMapRect
                
                self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
                
            }
        }
     
    }

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        userLocation = locValue
        
        

        mapView.mapType = MKMapType.standard
        
        self.userlocations.append(locValue)
        

        //let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        //let region = MKCoordinateRegion(center: locValue, span: span)
       //mapView.setRegion(region, animated: true)

        //let annotation = MKPointAnnotation()
        //annotation.coordinate = locValue
        //annotation.title = "user"
       //annotation.subtitle = "Ma Position"
       // mapView.addAnnotation(annotation)
        //centerMap(locValue)
        
        let location = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
        
        print("latt: \(locValue.latitude) lon: \(locValue.longitude)")
        drawMapPoint(location: location)
    }
    
    
    
}

     
    extension MapViewController : MKMapViewDelegate {
        
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
             guard let loc = userLocation.location else {
                             return
                         }
                         //permet de zoomer sur la localisation user
                         userCoordinate = MKCoordinateRegion(center: loc.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
                         mapView.setRegion(MKCoordinateRegion(center: loc.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000), animated: true)

                       let location = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
                       
                       print("latt: \(userLocation.coordinate.latitude) lon: \(userLocation.coordinate.longitude)")
                       drawMapPoint(location: location)
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let rendere = MKPolylineRenderer(overlay: overlay)
            rendere.lineWidth = 5
            rendere.strokeColor = .systemBlue
            
            return rendere
        }
    }
