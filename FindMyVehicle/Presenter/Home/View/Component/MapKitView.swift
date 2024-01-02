//
//  MapKitView.swift
//  FindMyVehicle
//
//  Created by ndyyy on 23/12/23.
//

import UIKit
import MapKit
import Combine

class MapKitView: UIView, MKMapViewDelegate {
    var mapView: MKMapView!
    var region = MKCoordinateRegion()
    var cancellable = Set<AnyCancellable>()
//    var headingImageView: UIImageView!
    var headingView = HeadingView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    var heading = CLLocationDirection()
    
    init() {
        super.init(frame: .zero)
        setup()
        subscribers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: Delegate
extension MapKitView {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let identifier = "CustomPin"
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        
        annotationView.canShowCallout = true
        annotationView.image = UIImage(systemName: "car.fill")
        return annotationView
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(view.annotation?.title! ?? "TITLE")
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        if views.last?.annotation is MKUserLocation {
            print("did add view")
            addHeadingView(views.last!)
        }
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


//MARK: Subscribers
extension MapKitView{
    private func subscribers() {
        NotificationCenter.default.publisher(for: Notification.Name("AddPin"))
            .sink { data in
                let longitude = data.userInfo!["longitude"] as! Double
                let latitude = data.userInfo!["latitude"] as! Double
                let name = data.userInfo!["name"] as! String
                
                self.addPin(name: name, location: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            }
            .store(in: &cancellable)
        
        NotificationCenter.default.publisher(for: Notification.Name("Heading"))
            .sink { data in
                self.heading = data.userInfo!["heading"] as! CLLocationDirection
                print("heading UNC: ", self.heading)
                self.updateHeadingRotation()
            }
            .store(in: &cancellable)
    }
}

//MARK: Methods
extension MapKitView {
    
    func setLocation(with location: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
    }
    
    func addHeadingView(_ annotation: MKAnnotationView) {
//        if headingImageView == nil {
////            let image = UIImage(systemName: "arrowtriangle.up.fill")!
//            let image = UIImage(resource: .arrowLeft)
//            headingImageView = UIImageView()
//            headingImageView.image = image
//            headingImageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
////            headingImageView.contentMode = .center
//            
//            annotation.layer.backgroundColor = UIColor.green.cgColor
//        }
//        headingImageView.backgroundColor = .white
//        
//        headingView.removeFromSuperview()
//        annotation.addSubview(headingView)
        mapView.addSubview(headingView)
        annotation.insertSubview(headingView, at: 0)
    }
    
    func updateHeadingRotation() {
        let rotation = CGFloat( heading / 180 * Double.pi)
        headingView.transform = CGAffineTransform(rotationAngle: rotation)
    }
    
    private func addPin(name: String, location: CLLocationCoordinate2D) {
        let pin = MKPointAnnotation()
        pin.title = name
        pin.coordinate = location
        mapView.addAnnotation(pin)
    }
}
