//
//  ContentView.swift
//  4.RestroomFinder
//
//  Created by MANAS VIJAYWARGIYA on 24/12/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
  @Environment(\.httpClient) private var restroomClient
  @State private var locationManager = LocationManager.shared
  @State private var restrooms: [Restroom] = []
  @State private var selectedRestroom: Restroom?
  @State private var visibleRegion: MKCoordinateRegion?
  @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
  @State private var isLoading: Bool = false
  @State private var isAnimating: Bool = false
  
  var body: some View {
    ZStack {
      Map(position: $position) {
        ForEach(restrooms) { restroom in
          // Marker(restroom.name, coordinate: restroom.coordinate)
          Annotation(restroom.name, coordinate: restroom.coordinate) {
            Text("🚻")
              .scaleEffect(selectedRestroom == restroom ? 2.0: 1.0)
              .font(.title)
              .onTapGesture {
                withAnimation {
                  selectedRestroom = restroom
                }
              }
              .animation(.spring(duration: 0.25), value: selectedRestroom)
          }
        }
        
        UserAnnotation()
      }
    }.task(id: locationManager.region) {
      if let region = locationManager.region {
        visibleRegion = region
        await loadRestrooms()
      }
    }
    .onMapCameraChange {context in
      visibleRegion = context.region
    }
    .mapControls {
      MapUserLocationButton()
      MapCompass()
      MapScaleView()
    }
    .sheet(item: $selectedRestroom) { restroom in
      RestroomDetailView(restroom: restroom)
        .padding()
        .presentationDetents([.fraction(0.25)])
    }
    .overlay(alignment: .topLeading) {
      Button {
        isLoading = true
        isAnimating = true
        Task {
          await loadRestrooms()
          withAnimation {
            isAnimating = false // Stop the Animation
          }
          isLoading = false
        }
      } label: {
        Image(systemName: "arrow.clockwise.circle.fill")
          .font(.largeTitle)
          .foregroundStyle(.white, .blue)
          .rotationEffect(.degrees(isAnimating ? 360 : 0))
          .animation(isAnimating ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default, value: isAnimating)
      }.disabled(isLoading).padding()
    }
  }
  
  private func loadRestrooms() async {
    guard let region = visibleRegion else { return }
    let coordinate = region.center
    
    do {
      let washrooms = try await restroomClient.fetchRestrooms(url: Constants.Urls.restroomsByLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
      print("washrooms======>", washrooms)
      restrooms = washrooms
    } catch {
      print("Error==========>", error.localizedDescription)
    }
  }
}

#Preview {
  ContentView()
  // .environment(\.httpClient, MockRestroomClient())
    .environment(\.httpClient, RestroomClient())
}
