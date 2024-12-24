//
//  LocationManager.swift
//  1.Hello_Maps
//
//  Created by MANAS VIJAYWARGIYA on 24/12/24.
//

import Foundation
import MapKit
import Observation

@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
  static let shared = LocationManager()
  let manager: CLLocationManager = CLLocationManager()
  var region: MKCoordinateRegion = MKCoordinateRegion()
  
  override init() {
    super.init()
    self.manager.delegate = self
    manager.desiredAccuracy = kCLLocationAccuracyBest
  }
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    switch manager.authorizationStatus {
      case .notDetermined:
        manager.requestWhenInUseAuthorization()
      case .authorizedAlways, .authorizedWhenInUse:
        manager.requestLocation()
      case .denied:
        print("Denied")
      case .restricted:
        print("restricted")
      @unknown default:
        break
    }
  }
  
  // When a program update a location or find a location, this method fires
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    // takes the last location
    locations.last.map {
      region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude),
                                  span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    }
  }
  
  // When there is a problem, this method fires
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error)
  }
}
