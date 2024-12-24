//
//  MKCoordinateRegion+Extensions.swift
//  4.RestroomFinder
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
}
