//
//  MKCoordinateRegion+Ext.swift
//  1.Hello_Maps
//
//  Created by MANAS VIJAYWARGIYA on 24/12/24.
//

import Foundation
import MapKit

extension MKCoordinateRegion: Equatable {
  public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
    if lhs.center.latitude == rhs.center.latitude && lhs.span.latitudeDelta == rhs.span.latitudeDelta && lhs.span.longitudeDelta == rhs.span.longitudeDelta {
      return true
    } else {
      return false
    }
  }
  
  static var indiaGate: MKCoordinateRegion {
    MKCoordinateRegion(center: .indiaGate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
  }
  
  static var gatewayOfIndia: MKCoordinateRegion {
    MKCoordinateRegion(center: .gatewayOfIndia, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
  }
}
