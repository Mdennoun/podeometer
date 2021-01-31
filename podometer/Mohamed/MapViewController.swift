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
    
    @IBOutlet weak var startStopBTN: UIButton!
    
    var userCoordinate: MKCoordinateRegion?
    let locationManager = CLLocationManager()
    var userLocation: CLLocationCoordinate2D?
    var userlocations = [CLLocationCoordinate2D]()
    var mockLocations = [CLLocationCoordinate2D]()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            //test location
            //mockLocations.append(CLLocationCoordinate2D(latitude: 48.84224859971956, longitude: 48.84224859971956))
            mockLocations.append(CLLocationCoordinate2D(latitude: 48.842141, longitude: 2.320194))
            mockLocations.append(CLLocationCoordinate2D(latitude: 48.842156, longitude: 2.320238))
            mockLocations.append(CLLocationCoordinate2D(latitude: 48.842217, longitude: 2.320446))
            mockLocations.append(CLLocationCoordinate2D(latitude: 48.842290, longitude: 2.320698))
            mockLocations.append(CLLocationCoordinate2D(latitude: 48.842424, longitude: 2.320971))
            mockLocations.append(CLLocationCoordinate2D(latitude: 48.842516, longitude: 2.321026))
            mockLocations.append(CLLocationCoordinate2D(latitude: 48.842578, longitude: 2.321060))
            mockLocations.append(CLLocationCoordinate2D(latitude: 48.842619, longitude: 2.320977))
            //false loc
            mockLocations.append(CLLocationCoordinate2D(latitude: 48.842653 , longitude: 2.320909))
            mockLocations.append(CLLocationCoordinate2D(latitude: 48.84280852245356, longitude: 2.3210055127440237))
            
            mockLocations.append(CLLocationCoordinate2D(latitude: 48.844132, longitude: 2.322828))
            
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
    
    @IBAction func startStop(_ sender: Any) {
        //let color = UIColor(red: 20, green: 165, blue: 127, alpha: 0.5)
        
        if startStopBTN.titleLabel?.text ==  "Commancer" {
            
            startStopBTN.setTitle("Arrêter", for: .normal)
            startStopBTN.backgroundColor = .red
            
        } else {
            var isFirstLocation = true
            for location in self.mockLocations {
                var prevLocation = location
                if isFirstLocation {
                    isFirstLocation = false
                } else {
                   
                 
                    self.getDistance(prevCoordonate: prevLocation, nextCoordonate: location) { (distence) in
                        
                        print("la distance entre les deuc point est de \(distence)")
                        if distence > 20 {
                            self.createPath(sourceLocation: prevLocation, destinationLocation: location)
                        }
                        prevLocation = location
                    }
                    
                }
            }
            mapView.setRegion(MKCoordinateRegion(center: self.userLocation!, latitudinalMeters: 10000, longitudinalMeters: 10000), animated: true)

            startStopBTN.setTitle("Commancer", for: .normal)
            startStopBTN.backgroundColor = .systemGreen
            
        }
        
        
    }
    
     
        func createPath(sourceLocation : CLLocationCoordinate2D, destinationLocation : CLLocationCoordinate2D) {
        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        
        let sourceMapItem = MKMapItem(placemark: sourcePlaceMark)
        let destinationItem = MKMapItem(placemark: destinationPlaceMark)
        
        
        let sourceAnotation = MKPointAnnotation()
        sourceAnotation.title = "Delhi"
        sourceAnotation.subtitle = "The Capital of INIDA"
        if let location = sourcePlaceMark.location {
            sourceAnotation.coordinate = location.coordinate
        }
        
        let destinationAnotation = MKPointAnnotation()
        destinationAnotation.title = "Gurugram"
        destinationAnotation.subtitle = "The HUB of IT Industries"
        if let location = destinationPlaceMark.location {
            destinationAnotation.coordinate = location.coordinate
        }
        
        self.mapView.showAnnotations([sourceAnotation, destinationAnotation], animated: true)
        
        
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationItem
        directionRequest.transportType = .automobile
        
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
    
    func calculateDistancefrom(sourceLocation: MKMapItem, destinationLocation: MKMapItem, doneSearching: @escaping (_ expectedTravelTim: TimeInterval) -> Void) {

        let request: MKDirections.Request = MKDirections.Request()

        request.source = sourceLocation
        request.destination = destinationLocation
        request.requestsAlternateRoutes = true
        request.transportType = .automobile

        let directions = MKDirections(request: request)
        directions.calculate { (directions, error) in

            if var routeResponse = directions?.routes {
                routeResponse.sort(by: {$0.expectedTravelTime <
                    $1.expectedTravelTime})
                let quickestRouteForSegment: MKRoute = routeResponse[0]

                doneSearching(quickestRouteForSegment.distance)

            }
        }
    }

    func getDistance(prevCoordonate: CLLocationCoordinate2D,nextCoordonate: CLLocationCoordinate2D, completionHandler: @escaping (_ distance: Int) -> Void) {

        let destinationItem =  MKMapItem(placemark: MKPlacemark(coordinate: nextCoordonate))
        let sourceItem =  MKMapItem(placemark: MKPlacemark(coordinate: prevCoordonate))

            self.calculateDistancefrom(sourceLocation: sourceItem, destinationLocation: destinationItem, doneSearching: { distance in
                completionHandler(Int(distance))
            })
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
        // mapView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = locValue
        annotation.title = "user"
       annotation.subtitle = "Ma Position"
       mapView.addAnnotation(annotation)
        //centerMap(locValue)
        
        //let location = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
        
        //print("latt: \(locValue.latitude) lon: \(locValue.longitude)")
        //drawMapPoint(location: location)
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

                       
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let rendere = MKPolylineRenderer(overlay: overlay)
            rendere.lineWidth = 5
            rendere.strokeColor = .systemBlue
            
            return rendere
        }
    }
