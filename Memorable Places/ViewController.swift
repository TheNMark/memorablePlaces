//
//  ViewController.swift
//  Memorable Places
//
//  Created by Mark on 03/11/2018.
//  Copyright © 2018 NMA. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var mapOutlet: MKMapView!
    
    var manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longpress(gestureRecognizer:)))
        
        uilpgr.minimumPressDuration = 2
        
        mapOutlet.addGestureRecognizer(uilpgr)
        
        if activePlace == -1 {
            
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
            
        } else {
            // Get place details to display on map.
            
            if places.count > activePlace {
                
                if let name = places[activePlace]["name"] {
                    
                    if let lat = places[activePlace]["lat"] {
                        
                        if let lon = places[activePlace]["lon"] {
                            
                            if let latitude = Double(lat) {
                                
                                if let longitude = Double(lon) {
                                    
                                    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                                    
                                    let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                                    
                                    let region = MKCoordinateRegion(center: coordinate, span: span)
                                    
                                    self.mapOutlet.setRegion(region, animated: true)
                                    
                                    let annotation = MKPointAnnotation()
                                    
                                    annotation.coordinate = coordinate
                                    
                                    annotation.title = name
                                    
                                    self.mapOutlet.addAnnotation(annotation)
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }

    @objc func longpress(gestureRecognizer: UIGestureRecognizer) {
        
        if gestureRecognizer.state == .began {
            
            let touchPoint = gestureRecognizer.location(in: self.mapOutlet)
        
            let newCoordinate = self.mapOutlet.convert(touchPoint, toCoordinateFrom: mapOutlet)
        
            let location = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
            
            var title = ""
            
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
                
                if error != nil {
                    
                    print(error!)
                    
                } else {
                    
                    if let placemark = placemarks?[0] {
                        
                        if placemark.subThoroughfare != nil {
                            
                            title += placemark.subThoroughfare! + " "
                            
                        }
                        
                        if placemark.thoroughfare != nil {
                            
                            title += placemark.thoroughfare!
                            
                        }
                        
                    }
                    
                }
                
                if title == "" {
                    
                    title = "Added \(NSDate())"
                    
                }
                
                let annotation = MKPointAnnotation()
                
                annotation.coordinate = newCoordinate
                
                annotation.title = title
                
                self.mapOutlet.addAnnotation(annotation)
                
                places.append(["name":title, "lat":String(newCoordinate.latitude), "lon":String(newCoordinate.longitude)])
                
                UserDefaults.standard.set(places, forKey: "places")
                
            })
            
            
            
        }
        
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        self.mapOutlet.setRegion(region, animated: true)
        
    }
    
    
    
}

