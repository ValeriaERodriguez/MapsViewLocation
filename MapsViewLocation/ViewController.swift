//
//  ViewController.swift
//  MapsViewLocation
//
//  Created by Mac on 09/08/2022.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    private let map: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    var userLocation: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(map)
        title = "Home"
        
        LocationManager.shared.getUserLocation{ [weak self] location in
            DispatchQueue.main.async {
                guard let strongSelf = self else{ return }
                
                strongSelf.addMapPin(with: location)
                }
    }

        
    }
    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        map.frame = view.bounds
    }

    func addMapPin(with location: CLLocation) {
        let pin = MKPointAnnotation()
        pin.coordinate = location.coordinate
        
    
        map.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)), animated: true)
        map.addAnnotation(pin)
                                
        LocationManager.shared.resolveLocationName(with: location) { [weak self] locationName in self?.title = locationName
        }
    }
    
    func mapPin(_ mapPin: MKMapView,viewFor pin: MKAnnotation) -> MKAnnotationView {
        let marker = MKMarkerAnnotationView(annotation: pin, reuseIdentifier: "pinchitorojo")
        marker.isDraggable = true
        marker.canShowCallout = false
        return marker
    }

    
}
