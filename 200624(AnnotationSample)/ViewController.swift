//
//  ViewController.swift
//  200624(AnnotationSample)
//
//  Created by hyu on R 2/06/24.
//  Copyright © Reiwa 2 hyu. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
     
    struct Annotation {
        let address:String
        let title:String?
        let subtitle:String?
        
    }
    
    let locationPoint:CLLocationCoordinate2D = CLLocationCoordinate2DMake(35.725456, 139.7152419)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.locationManager.delegate = self
        self.mapView.delegate = self
    }
    
    private func startUpdatingLocation() {
        switch CLLocationManager.authorizationStatus(){
        case.notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            break
        }
        locationManager.startUpdatingLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startUpdatingLocation()
        
        let annoPointSchool = Annotation(address: "東京", title: "東京", subtitle: "minnakoi")
        
        addAnno(with: annoPointSchool)
        
        var region:MKCoordinateRegion = mapView.region
        region.center = locationPoint
        region.span.latitudeDelta = 0.002
        region.span.longitudeDelta = 0.002
        mapView.setRegion(region, animated: true)
        self.view.addSubview(mapView)
        
        mapView.mapType = MKMapType.standard
        mapView.userTrackingMode = MKUserTrackingMode.follow
        mapView.userTrackingMode = MKUserTrackingMode.followWithHeading
    
    }
    private func addAnno(with annotation:Annotation){
        
        let dropAnnotation = MKPointAnnotation()
        dropAnnotation.coordinate = locationPoint
        dropAnnotation.title = annotation.title
        dropAnnotation.subtitle = annotation.subtitle
        
        self.mapView.addAnnotation(dropAnnotation)
    }
}

