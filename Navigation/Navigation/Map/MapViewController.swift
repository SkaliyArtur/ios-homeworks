//
//  MapViewController.swift
//  Navigation
//
//  Created by Artur Skaliy on 19.01.2023.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    private lazy var mapView = MKMapView()
    private lazy var locationManager = CLLocationManager()
    var currentPlacemark: CLPlacemark?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        checkUserLocationPermission()
        setupMapView()
        setupGesture()
    }
    
    func setupMapView() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.delegate = self
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
            let pointAnnotation = MKPointAnnotation()
            pointAnnotation.coordinate = pointCoordinate
            pointAnnotation.title = NSLocalizedString("New Point", comment: "")
            mapView.addAnnotation(pointAnnotation)
        }
        if longGesture.state != UIGestureRecognizer.State.began {
            return
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if(annotation is MKUserLocation) {
            return nil
        }
        let reuseID = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID) as? MKPinAnnotationView
        if(pinView == nil) {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
        }
        let button = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
        button.setBackgroundImage(UIImage(systemName: "figure.walk"), for: .normal)
        button.addTarget(self, action: #selector(addRoute), for: .touchUpInside)
        pinView?.rightCalloutAccessoryView = button
        return pinView
    }
    
    func checkUserLocationPermission() {
        print("authorizationStatus: \(locationManager.authorizationStatus.rawValue)")
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {return}
        let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5))
        mapView.setRegion(region, animated: true)
    }
    
    @objc func addRoute() {
        mapView.removeOverlays(mapView.overlays)
        let request = MKDirections.Request()
        guard let currentPlacemark = currentPlacemark else {
                return
            }
        let destinationPlaceMark = MKPlacemark(placemark: currentPlacemark)
        request.source = MKMapItem.forCurrentLocation()
        request.destination = MKMapItem(placemark: destinationPlaceMark)
        request.transportType = .walking
        let directions = MKDirections(request: request)
        directions.calculate{ [weak self] response, error in
            guard let response = response  else {return}
            let route = response.routes[0]
            self?.mapView.addOverlay(route.polyline, level: .aboveRoads)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let location = view.annotation as? MKPointAnnotation {
            self.currentPlacemark = MKPlacemark(coordinate: location.coordinate)
            }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .blue
        return render
    }
    
}
