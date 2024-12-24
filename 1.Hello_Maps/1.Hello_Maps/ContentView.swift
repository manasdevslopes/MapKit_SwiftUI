//
//  ContentView.swift
//  1.Hello_Maps
//
//  Created by MANAS VIJAYWARGIYA on 24/12/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
  @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
  // Same as @StateObject, as LocationManager having @Observable
  @State private var locationManager = LocationManager.shared
  
  @State private var selectedMapOption: MapOptions = .standard
  
  var body: some View {
    ZStack(alignment: .top) {
      Map(position: $position) {
        // Marker("Coffee", coordinate: .coffee)
        Annotation("India Gate", coordinate: .indiaGate) {
          Image(systemName: "building.columns.circle")
          // Image(systemName: "cup.and.saucer.fill")
            .padding(4)
            .foregroundStyle(.white)
            .background(.indigo)
            .clipShape(RoundedRectangle(cornerRadius: 4.0, style: .continuous))
        }
        // Marker("Restaurant", coordinate: .restaurant)
        Annotation("Gateway of India", coordinate: .gatewayOfIndia) {
          Image(systemName: "building.columns.circle")
          // Image(systemName: "fork.knife.circle")
            .padding(4)
            .foregroundStyle(.white)
            .background(.indigo)
            .clipShape(Circle())
        }
        // Marker("Gateway of India", coordinate: .gatewayOfIndia)
        
        UserAnnotation()
      }
      .mapStyle(selectedMapOption.mapStyle)
      .mapControls {
        MapUserLocationButton()
        MapCompass()
        MapScaleView()
      }
      .onChange(of: locationManager.region) {
        withAnimation {
          position = .region(locationManager.region)
        }
      }
      Picker("Map Style", selection: $selectedMapOption) {
        ForEach(MapOptions.allCases) { mapOption in
          Text(mapOption.rawValue.capitalized).tag(mapOption)
        }
      }
      .pickerStyle(.segmented)
      .background(.white)
      .padding([.horizontal])
      .padding([.top], 60)
      
      VStack {
        Spacer()
        HStack {
          Button("India Gate") {
            withAnimation {
              position = .region(.indiaGate)
            }
          }.buttonStyle(.borderedProminent).tint(.red)
          Button("Gateway of India") {
            withAnimation {
              position = .region(.gatewayOfIndia)
            }
          }.buttonStyle(.borderedProminent).tint(.brown)
        }
      }
    }
  }
}

#Preview {
  ContentView()
}
