//
//  Restroom.swift
//  4.RestroomFinder
//
//  Created by MANAS VIJAYWARGIYA on 24/12/24.
//

import Foundation
import CoreLocation
import MapKit
import Contacts

struct Restroom: Decodable, Identifiable, Equatable {
  
  let id: Int
  let name: String
  let street: String
  let city: String
  let state: String
  let comment: String?
  let accessible: Bool
  let unisex: Bool
  let changingTable: Bool
  let latitude: Double
  let longitude: Double
  
  var address: String {
    "\(street), \(city) \(state)"
  }
  
  var coordinate: CLLocationCoordinate2D {
    CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
  }
  
  enum CodingKeys: String, CodingKey, Decodable {
    case id
    case name
    case street
    case city
    case state
    case comment
    case accessible
    case unisex
    case changingTable = "changing_table"
    case latitude
    case longitude
  }
  
}

extension Restroom {
  var mapItem: MKMapItem {
    var addressDictionary: [String: Any] = [
      CNPostalAddressStreetKey: self.street,
      CNPostalAddressCityKey: self.city,
      CNPostalAddressStateKey: self.state
    ]
    
    let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
    let mapItem = MKMapItem(placemark: placemark)
    mapItem.name = name
    return mapItem
  }
}
