//
//  ViewController.swift
//  MapApp
//
//  Created by Hector Montero on 1/3/17.
//  Copyright © 2017 Hector Montero. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    let locationManager = CLLocationManager()
    let DEFAULT_ZOOM_VALUE: Float = 14.0
    let GOOGLE_MAPS_URL_SCHEME: String = "comgooglemaps"
    let WAZE_URL_SCHEME: String = "waze"
    
    var mapView: GMSMapView! = nil
    
    //private static final LatLng mlecarosHouseCoordinates = new LatLng(-12.070504f, -76.938820f);
    let lecarosHouseCoordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: -12.070504, longitude: -76.938820)
    var currentLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: -12.070504, longitude: -76.938820)
    
    
    
    override func loadView() {
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: DEFAULT_ZOOM_VALUE))
        self.view = mapView
        mapView.isMyLocationEnabled = true
        mapView.settings.zoomGestures = true
        mapView.settings.allowScrollGesturesDuringRotateOrZoom = true
        mapView.delegate = self
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = lecarosHouseCoordinates
        marker.title = "Casa Lecaros"
        marker.snippet = "Test"
        marker.map = mapView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = (manager.location?.coordinate)!
        print("currentLocation latitude: \(currentLocation.latitude), longitude: \(currentLocation.longitude)")
        mapView.camera = GMSCameraPosition.camera(withLatitude: currentLocation.latitude, longitude: currentLocation.longitude, zoom: DEFAULT_ZOOM_VALUE)
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
//        let alert = UIAlertController(title: "Alert Test", message: "Alert", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        self.present(alert, animated: true, completion: nil)

        // NAVIGATE WITH IOS MAPS
        
//        let regionDistance: CLLocationDistance = 10000
//        let regionSpan = MKCoordinateRegionMakeWithDistance(lecarosHouseCoordinates, regionDistance, regionDistance)
//        
//        let options = [
//            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
//            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
//        ]
//        
//        let placemark = MKPlacemark(coordinate: lecarosHouseCoordinates, addressDictionary: nil)
//        let mapItem = MKMapItem(placemark: placemark)
//        mapItem.name = "Lecaros House"
//        mapItem.openInMaps(launchOptions: options)
        
//        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
//            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"comgooglemaps://?center=%f,%f&q=%f,%f",mosqueLocation.latitude,mosqueLocation.longitude, mosqueLocation.latitude,mosqueLocation.longitude]];
//            [[UIApplication sharedApplication] openURL:url];
//        } else {
//            NSLog(@"Can't use comgooglemaps://");
//        }
        
//        let url: NSURL = NSURL.init(string: NSString.init(format: "%s://?center=%f,%f&q=%f,%f&zoom=%f", GOOGLE_MAPS_URL_SCHEME , currentLocation.latitude, currentLocation.longitude, lecarosHouseCoordinates.latitude, lecarosHouseCoordinates.longitude, DEFAULT_ZOOM_VALUE) as String)!
        
        let urlString: NSString = NSString.init(format: "%@://?center=%f,%f&q=%f,%f&zoom=%f", WAZE_URL_SCHEME, currentLocation.latitude, currentLocation.longitude, lecarosHouseCoordinates.latitude, lecarosHouseCoordinates.longitude, DEFAULT_ZOOM_VALUE)
        //let urlString: NSString = NSString.init(format: "%@://?center=%f,%f&q=%f,%f&zoom=%f", GOOGLE_MAPS_URL_SCHEME, currentLocation.latitude, currentLocation.longitude, lecarosHouseCoordinates.latitude, lecarosHouseCoordinates.longitude, DEFAULT_ZOOM_VALUE)
        
        print("urlString: \(urlString)")
        
        let url: NSURL = NSURL.init(string: urlString as String)!
        print("Open url: \(url.absoluteString)")
        
        if UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.open(url as URL, options: [ : ], completionHandler: nil)
        }
        
    }
}

