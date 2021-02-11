//
//  RoutingViewController.swift
//  podometer
//
//  Created by Mohamed dennoun on 09/02/2021.
//  Copyright © 2021 Mohamed dennoun. All rights reserved.
//


import UIKit
import MapKit
import CoreLocation
import Layoutless
import AVFoundation

class RoutingViewController: UIViewController {
    
    var steps: [MKRoute.Step] = []
    var stepCounter = 0
    var route: MKRoute?
    var showMapRoute = false
    var navigationStarted = false
    let locationDistance: Double = 500
    
    var speechSynthesiser = AVSpeechSynthesizer()
    var utterance : AVSpeechUtterance = AVSpeechUtterance(string: "")
    
    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        
        if CLLocationManager.locationServicesEnabled() {
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            handleAuthorizationStatus(locationManager: locationManager, status: CLLocationManager.authorizationStatus())
        } else {
            
            print("Location are not enabled")
        }
        
        return locationManager
    }()
    
    lazy var directionLabel: UILabel = {
        let label = UILabel()
        label.text = "Ou voulez vous allez ?"
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter votre destination"
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    lazy var getDirectionButton: UIButton = {
        let button = UIButton()
        button.setTitle("Direction", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(getDirectionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var startStopButton: UIButton = {
        let button = UIButton()
        button.setTitle("Commancer le parcours", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(startStopButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.delegate = self
        mapView.showsUserLocation = true
        return mapView
    }()
    
    @objc fileprivate func getDirectionButtonTapped() {
        guard let text = textField.text else { return }
        showMapRoute = true
        textField.endEditing(true)
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(text) { (placemarks, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            guard let placemarks = placemarks,
                let placemark = placemarks.first,
                let location = placemark.location
                else { return }
            let destinationCoordonate = location.coordinate
            self.mapRoute(destinationCoordinate: destinationCoordonate)
            
        }
    }
    
    @objc fileprivate func startStopButtonTapped() {
        
        if !navigationStarted {
            
            showMapRoute = true
            if let location = locationManager.location  {
                let center = location.coordinate
                centerViewToUserLocation(center: center)
            }
            
        } else {
            if let route = route {

                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16), animated: true)
                self.steps.removeAll()
                self.stepCounter = 0
            }
        }
        navigationStarted.toggle()
        startStopButton.setTitle(navigationStarted ? "Commencer le parcours" : "Arreter la parcours", for: .normal)
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        UserDefaults.standard.set(["fr"], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        
        
        utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.Thomas-compact")
        setupViews()
        locationManager.startUpdatingLocation()
    }

    fileprivate func setupViews() {
        view.backgroundColor = UIColor(named: "systemBackground")
        
        stack(.vertical)(
            directionLabel.insetting(by: 16),
            stack(.horizontal, spacing: 16)(
                textField,
                getDirectionButton
            ).insetting(by: 16),
            startStopButton.insetting(by: 16),
            mapView
        ).fillingParent(relativeToSafeArea: true).layout(in: view)
    }
    
    fileprivate func centerViewToUserLocation(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: locationDistance, longitudinalMeters: locationDistance)
        mapView.setRegion(region, animated: true)
        
    }
    
    fileprivate func handleAuthorizationStatus(locationManager: CLLocationManager, status: CLAuthorizationStatus) {
        
        switch status {
        
        
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("location is restricted")
            break
        case .denied:
            print("location is denied")
            break
        case .authorizedAlways:
            if let center = locationManager.location?.coordinate {
                centerViewToUserLocation(center: center)
            }
            break
        case .authorizedWhenInUse:
            break
        @unknown default:
            // nothing
            break
        }
    }
    
    fileprivate func mapRoute(destinationCoordinate: CLLocationCoordinate2D) {
        guard let sourceCoordinte = locationManager.location?.coordinate else { return }
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinte)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destinationItem = MKMapItem(placemark: destinationPlacemark)
        
        let routeRequest = MKDirections.Request()
        routeRequest.source = sourceItem
        routeRequest.destination = destinationItem
        routeRequest.transportType = .walking
        
        let directions = MKDirections(request: routeRequest)
        directions.calculate { (response, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            guard let response = response,
                let route = response.routes.first
                else {
                    return
            }
            self.route = route
            self.mapView.addOverlay(route.polyline)
            self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16), animated: true)
            self.getRouteSteps(route: route)
            
        }
    }
    
    fileprivate func getRouteSteps(route: MKRoute) {
        for monitoredRegion in locationManager.monitoredRegions {
            locationManager.stopMonitoring(for: monitoredRegion)
        }
        let steps = route.steps
        for i in 0..<steps.count {
            let step = steps[i]
            print(step.instructions)
            print(step.distance)
            
            let region = CLCircularRegion(center: step.polyline.coordinate, radius: 20, identifier: "\(i)")
            locationManager.startMonitoring(for: region)
        }
        
        stepCounter += 1
        let initialMessage = "dans \(steps[stepCounter].distance) metres \(steps[stepCounter].instructions), puis dans \(steps[stepCounter + 1].distance) metre \(steps[stepCounter + 1].instructions)"
        directionLabel.text = initialMessage
        let utterance = AVSpeechUtterance(string: initialMessage)
        utterance.voice = AVSpeechSynthesisVoice(language: "fr-FR")
        speechSynthesiser.speak(utterance)
        
    }

}

extension RoutingViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !showMapRoute {
            if let location = locations.last {
                let center = location.coordinate
                centerViewToUserLocation(center: center)
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handleAuthorizationStatus(locationManager: locationManager, status: status)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if stepCounter < steps.count {
            let message = "dans \(steps[stepCounter].distance) metres \(steps[stepCounter].instructions)"
            directionLabel.text = message
            utterance = AVSpeechUtterance(string: message)
            utterance.voice = AVSpeechSynthesisVoice(language: "fr-FR")
            speechSynthesiser.speak(utterance)
            
        } else {
            let message = "Vous êtes arriver a votre destination"
            directionLabel.text = message
            stepCounter = 0
            navigationStarted = false
            for monitoredRegion in locationManager.monitoredRegions {
                locationManager.stopMonitoring(for: monitoredRegion)
            }
        }
        
    }
    
}
extension RoutingViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .systemBlue
        return renderer
    }
}
