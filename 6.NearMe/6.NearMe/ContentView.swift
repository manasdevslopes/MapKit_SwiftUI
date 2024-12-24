//
//  ContentView.swift
//  6.NearMe
//
//  Created by MANAS VIJAYWARGIYA on 24/12/24.
//

import SwiftUI
import MapKit

enum DisplayMode {
  case searchAndList
  case detail
}

struct ContentView: View {
  @State private var query: String = ""
  @State private var selectedDetent: PresentationDetent = .fraction(0.15)
  // Same as @StateObject, as LocationManager having @Observable
  @State private var locationManager = LocationManager.shared
  @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
  @State private var isSearching: Bool = false
  @State private var mapItems: [MKMapItem] = []
  @State private var visibleRegion: MKCoordinateRegion?
  @State private var selectedMapItem: MKMapItem?
  @State private var displayMode: DisplayMode = .searchAndList
  @State private var lookAroundScene: MKLookAroundScene?
  @State private var route: MKRoute?
  @State private var directions: [String] = []
  @State private var showDirection: Bool = false
  @State private var clearItem: Bool = false
  
  var body: some View {
    ZStack {
      Map(position: $position, selection: $selectedMapItem) {
        ForEach(mapItems, id: \.self) { mapItem in
          Marker(item: mapItem)
        }
        
        if let route {
          MapPolyline(route).stroke(.blue, lineWidth: 5)
        }
        UserAnnotation()
      }
      .onChange(of: locationManager.region) { oldValue, newValue in
        withAnimation {
          position = .region(locationManager.region)
        }
      }
      .sheet(isPresented: .constant(true)) {
        VStack {
          switch displayMode {
            case .searchAndList:
              SearchBarView(search: $query, isSearching: $isSearching, clearItem: $clearItem)
                .padding(.top, selectedDetent == .medium || selectedDetent == .large ? -10 : 10)
                .padding([.top])
              if !mapItems.isEmpty {
                Divider().padding(.leading)
              }
              PlaceListView(mapItems: mapItems, selectedMapItem: $selectedMapItem)
            case .detail:
              SelectedPlaceDetailView(mapItem: $selectedMapItem).padding()
              if selectedDetent == .medium || selectedDetent == .large {
                if let selectedMapItem {
                  ActionButtons(mapItem: selectedMapItem, showDirection: { showDirection = true }, directionCount: directions.count).padding()
                }
                if showDirection {
                  ZStack(alignment: .topTrailing) {
                    VStack(spacing: 0) {
                      Text("Directions").font(.largeTitle).bold().padding()
                      
                      Divider().background(Color(UIColor.systemBlue))
                      
                      List(0..<self.directions.count, id: \.self) { i in
                        Text(self.directions[i]).padding()
                      }
                      .listStyle(.plain)
                    }
                    Image(systemName: "xmark.circle.fill")
                      .padding([.trailing], 10).padding([.top], 25)
                      .onTapGesture {
                        showDirection = false
                      }
                  }
                }
                if !showDirection {
                  LookAroundPreview(initialScene: lookAroundScene)
                }
              }
          }
          
          Spacer()
        }
        .presentationDetents([.fraction(0.15), .medium, .large], selection: $selectedDetent)
        .presentationDragIndicator(.visible)
        .interactiveDismissDisabled()
        .presentationBackgroundInteraction(.enabled(upThrough: .medium))
      }
    }
    .overlay(alignment: .center) {
      if isSearching {
        VStack {
          ProgressView().padding(20).background(.thinMaterial).clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.4)) // Semi-tranparent background to indicate loading state
        .edgesIgnoringSafeArea(.all) // Ensure the overlay covers the entire screen
        .disabled(true) // Disable interactions with the overlay
      }
    }
    .onChange(of: selectedMapItem) {oldValue, newValue in
      if selectedMapItem != nil {
        displayMode = .detail
        // requestCalculateDirections()
      } else {
        route = nil
        displayMode = .searchAndList
      }
    }
    .onMapCameraChange { context in
      visibleRegion = context.region
    }
    .task(id: selectedMapItem) {
      lookAroundScene = nil
      guard let selectedMapItem else { return }
        let request = MKLookAroundSceneRequest(mapItem: selectedMapItem)
        lookAroundScene = try? await request.scene
        await requestCalculateDirections()
    }
    .task(id: isSearching) {
      if isSearching {
        await search()
      }
    }
    .task(id: clearItem) {
      if clearItem {
        mapItems = []
        selectedMapItem = nil
        displayMode = .searchAndList
        route = nil
      }
    }
    .onChange(of: route) { oldValue, newValue in
      showDirection = false
      if route != nil {
        getDirections()
      }
    }
  }
  
  private func search() async {
    do {
      mapItems = try await performSearch(searchTerm: query, visibleRegion: visibleRegion)
      print("mapItems=======>", mapItems)
      isSearching = false
    } catch {
      mapItems = []
      print("Search_query----->", error.localizedDescription)
      isSearching = false
    }
  }
  
  private func requestCalculateDirections() async {
    route = nil
    if let selectedMapItem {
      guard let currentUserLocation = locationManager.manager.location else { return }
      let startingMapItem = MKMapItem(placemark: MKPlacemark(coordinate: currentUserLocation.coordinate))
      self.route = await calculateDirections(from: startingMapItem, to: selectedMapItem)
    }
  }
  
  private func getDirections() {
    guard let route = route else { return }
    print("ROUTE======>", route)
    self.directions = route.steps.map { $0.instructions }.filter { !$0.isEmpty }
    print("DIRECTIONS=========>", directions)
  }
}

#Preview {
  ContentView()
}
