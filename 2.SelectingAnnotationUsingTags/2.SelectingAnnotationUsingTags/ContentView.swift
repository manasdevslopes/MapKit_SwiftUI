//
//  ContentView.swift
//  2.SelectingAnnotationUsingTags
//
//  Created by MANAS VIJAYWARGIYA on 24/12/24.
//

import SwiftUI
import MapKit

enum PlaceType {
  case coffee
  case burger
}

struct Place: Identifiable, Hashable {
  let id = UUID()
  let name: String
  let latitude: CLLocationDegrees
  let longitude: CLLocationDegrees
  let placeType: PlaceType
  
  var coordinate: CLLocationCoordinate2D {
    CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
  }
}

struct ContentView: View {
  let places = [Place(name: "Starbucks", latitude: 37.33729592159919, longitude: -122.01497877337277, placeType: .coffee), Place(name: "Smashburger", latitude: 37.33311221458044, longitude: -122.01486701936605, placeType: .burger)]
  
  @State private var selectedPlace: Place?
  
  var body: some View {
    Map(selection: $selectedPlace) {
      ForEach(places) {place in
        switch place.placeType {
          case .burger:
            Marker(place.name, coordinate: place.coordinate)
              .tag(place)
          case .coffee:
            Annotation(place.name, coordinate: place.coordinate) {
              Image(systemName: "cup.and.saucer.fill")
            }.tag(place)
        }
      }
    }
    .onChange(of: selectedPlace) {
      if let place = selectedPlace {
        print(place)
      }
    }
  }
}

#Preview {
  ContentView()
}
