//
//  ViewController.swift
//  mandatorymap
//
//  Created by admin on 11/06/2020.
//  Copyright © 2020 kea. All rights reserved.
//

import UIKit
import FirebaseFirestore
import MapKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var textField: UITextField!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.startUpdatingLocation()
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress(_:)))
        self.map.addGestureRecognizer(gesture)
        self.map.isUserInteractionEnabled = true
        FirebaseRepo.startListener(vc: self)
        map.showsUserLocation = true
        map.delegate = self
        
    }
    
    
    func updateMarkers(snap: QuerySnapshot){
        let markers = MapDataAdapter.getMKAnnotationsFromData(snap: snap)
        
        map.removeAnnotations(map.annotations)
        map.addAnnotations(markers)
    }
    
    @IBAction func longPress(_ sender: UILongPressGestureRecognizer) {
        
            let alert = UIAlertController(title: "Title", message: "What do you wanna call this spot?", preferredStyle: .alert)
            
            alert.addTextField{ (textField) in
                textField.placeholder = "Location Name"
            }
            
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { [weak alert] (_) in
                let textField = alert?.textFields![0]
                print("Text Field contains: \(textField?.text ?? "")")
                DispatchQueue.main.async {
                    self.addMarkerWithUserTitle (sender , title : textField?.text ?? "")
                }
            }))
            self.present(alert, animated: true, completion: nil)
    }
    
    func addMarkerWithUserTitle(_ sender: UILongPressGestureRecognizer, title: String){
        
            let cgPoint = sender.location(in: map)
            let coordinate2d = map.convert(cgPoint, toCoordinateFrom: map)
            
            print("long press at \(coordinate2d)")
            
            FirebaseRepo.addMarkers(title: title, lat: coordinate2d.latitude, long: coordinate2d.longitude)
        
    }
    
    
    @IBAction func startUpdate(_ sender: UIButton) {
        print("Start button pressed")
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func stopUpdate(_ sender: UIButton) {
        print("Stop button pressed")
        locationManager.stopUpdatingLocation()
    }
    
    fileprivate func createDemoMarkers(){
        let marker = MKPointAnnotation()
        marker.title = "Testing"
        
        let location = CLLocationCoordinate2D(latitude: 55.7, longitude: 12.5)
        marker.coordinate = location
        
        map.addAnnotation(marker)
    }
    
}

extension ViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coordIt = locations.last?.coordinate {
            print("new location")
        
            let region = MKCoordinateRegion(center: coordIt, latitudinalMeters: 300, longitudinalMeters: 300)
        
            map.setRegion(region, animated: true)
            
        }
    }
}

extension ViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? Marker else{
            return nil
        }
        
        let identifier = "pin"
        var view: MKMarkerAnnotationView
        
        if let dequedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequedView.annotation = annotation
            view = dequedView
        } else{
            view = MKMarkerAnnotationView(
                annotation: annotation, reuseIdentifier: identifier
            )
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 10)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let marker = view.annotation as? Marker else{
            return
        }
        
        let launchOptions = [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
        ]
        marker.mapItem?.openInMaps(launchOptions: launchOptions)
    }
}
