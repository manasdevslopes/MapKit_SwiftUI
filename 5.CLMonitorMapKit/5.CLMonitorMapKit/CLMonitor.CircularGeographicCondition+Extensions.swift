//
//  CLMonitor.CircularGeographicCondition+Extensions.swift
//  5.CLMonitorMapKit
//
//  Created by MANAS VIJAYWARGIYA on 24/12/24.
//

import Foundation
import MapKit

extension CLMonitor.CircularGeographicCondition {
  
  static var cupertinoVillage: CLMonitor.CircularGeographicCondition {
    CLMonitor.CircularGeographicCondition(center: .cupertinoVillage, radius: 50)
  }
  
  static var appleCampus: CLMonitor.CircularGeographicCondition {
    CLMonitor.CircularGeographicCondition(center: .appleCampus, radius: 50)
  }
  
}
