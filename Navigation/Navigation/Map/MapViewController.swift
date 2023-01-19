//
//  MapViewController.swift
//  Navigation
//
//  Created by Artur Skaliy on 19.01.2023.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    private lazy var mapView = MKMapView()
    private lazy var locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkUserLocationPermission()
        setupMapView()
        setupGesture()
    }
    
    func setupMapView() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        view.backgroundColor = .white
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func setupGesture() {
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(addWaypoint(longGesture:)))
        self.mapView.addGestureRecognizer(longGesture)
    }
    
    @objc func addWaypoint(longGesture: UILongPressGestureRecognizer) {

        if longGesture.state != UIGestureRecognizer.State.ended {
            let touchPoint = longGesture.location(in: mapView)
            let pointCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            
            print("Latitude: \(pointCoordinate.latitude), longitude: \(pointCoordinate.longitude)")
            
            let pointAnnotation = MKPointAnnotation()
            pointAnnotation.coordinate = pointCoordinate
            pointAnnotation.title = "Latitude: \(pointCoordinate.latitude), longitude: \(pointCoordinate.longitude)"
            mapView.addAnnotation(pointAnnotation)
        }
        if longGesture.state != UIGestureRecognizer.State.began {
            return
        }
    }
    
    func checkUserLocationPermission() {
        print("authorizationStatus: \(locationManager.authorizationStatus.rawValue)")
        locationManager.requestWhenInUseAuthorization()
    }
    
}
