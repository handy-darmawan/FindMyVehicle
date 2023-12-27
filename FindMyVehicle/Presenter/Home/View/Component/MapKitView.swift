//
//  MapKitView.swift
//  FindMyVehicle
//
//  Created by ndyyy on 23/12/23.
//

import UIKit
import MapKit

class MapKitView: UIView, MKMapViewDelegate {
    var mapView: MKMapView!
    var region = MKCoordinateRegion()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setups
extension MapKitView {
    private func setup() {
        mapView = MKMapView(frame: .zero)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
//        mapView.showsUserTrackingButton = true
        mapView.showsCompass = true
        mapView.showsScale = true
        
        self.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

//MARK: Methods
extension MapKitView {
    
    func setLocation(with location: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
    }
    
    func setHeading(with heading: CLHeading?) {
        guard let heading = heading else {return}
        mapView.camera.heading = heading.trueHeading
        mapView.setCamera(mapView.camera, animated: true)
    }
    
    func addPin(name: String, location: CLLocationCoordinate2D) {
        let pin = MKPointAnnotation()
        pin.title = name
        pin.coordinate = location
        mapView.addAnnotation(pin)
    }
}


