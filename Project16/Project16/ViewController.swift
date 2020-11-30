//
//  ViewController.swift
//  Project16
//
//  Created by Alanna Romao on 11/11/20.
//

import UIKit
import MapKit
import WebKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(mapPicker))
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.77), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Lights.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            (annotationView as? MKPinAnnotationView)?.pinTintColor = UIColor.purple
            annotationView?.tintColor = UIColor.purple
            annotationView?.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    @objc func goBack() {
        self.view.bringSubviewToFront(mapView)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        let title = capital.title
        let vc = WebViewController()
        vc.capital = title
        navigationController?.pushViewController(vc, animated: true)

        
        
        //let placeName = capital.title
        //let placeInfo = capital.info
        
        //let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        //ac.addAction(UIAlertAction(title: "OK", style: .default))
        //present(ac, animated: true)
    }
    
    @objc func mapPicker() {
        let ac = UIAlertController(title: "Type of map", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: mapper))
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: mapper))
        ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: mapper))
        present(ac, animated: true)
    }
    
    func mapper(action: UIAlertAction) {
        guard let actionTitle = action.title else { return }
        if actionTitle == "Satellite" {
            mapView.mapType = .satellite
        } else if actionTitle == "Hybrid" {
            mapView.mapType = .hybrid
        } else {
            mapView.mapType = .standard
        }
        
    }


}

