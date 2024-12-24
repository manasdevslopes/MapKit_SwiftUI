//
//  ContentView.swift
//  3.MapPolygonOverlays
//
//  Created by MANAS VIJAYWARGIYA on 24/12/24.
//

import SwiftUI
import MapKit

extension Array where Element == CLLocationCoordinate2D {
  static var cupertinoVillage: [CLLocationCoordinate2D] {
    return [CLLocationCoordinate2D(latitude: 37.336991325714166, longitude: -122.01563341364727), CLLocationCoordinate2D(latitude: 37.33668523636697, longitude: -122.01608148607147), CLLocationCoordinate2D(latitude: 37.3358322172734, longitude: -122.01611932844438), CLLocationCoordinate2D(latitude: 37.3352150445003, longitude: -122.01531783535485), CLLocationCoordinate2D(latitude: 37.33600785319578, longitude: -122.01462364874855) ]
  }
}

extension CLLocationCoordinate2D {
  static var cupertinoVillage: CLLocationCoordinate2D {
    return CLLocationCoordinate2D(latitude: 37.33590830029923, longitude: -122.01544480526286)
  }
}

struct ContentView: View {
  var body: some View {
    Map {
      MapPolygon(coordinates: .cupertinoVillage)
        .foregroundStyle(.indigo.opacity(0.5))
      
      MapCircle(center: .cupertinoVillage, radius: 50)
        .foregroundStyle(.pink.opacity(0.5))
        .mapOverlayLevel(level: .aboveRoads)
    }
  }
}

#Preview {
  ContentView()
}
