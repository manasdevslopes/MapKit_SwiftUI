//
// Created for MyTrips
// by  Stewart Lynch on 2023-12-31
//
// Follow me on Mastodon: @StewartLynch@iosdev.space
// Follow me on Threads: @StewartLynch (https://www.threads.net)
// Follow me on X: https://x.com/StewartLynch
// Follow me on LinkedIn: https://linkedin.com/in/StewartLynch
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch

// Click - Hold - Drag - For Move in Map
// Double Click - Hold - Drag - Zoom In/Zoom Out
// Shift Key - Click - Hold - Drag - Zoom In/Zoom Out
// Double click at location - to zoom In
// Option Key - Click - Zoom In/Zoom Out
// Option Key - Click - Drag Clockwise or counter clockwise - Rotate Map
// Option + Shift Keys - Click - Hold - Drag - to elevate Map
//

import SwiftUI
import SwiftData

@main
struct MyTripsApp: App {
    @State private var locationManager = LocationManager()
    var body: some Scene {
        WindowGroup {
            if locationManager.isAuthorized {
                StartTab()
            } else {
                LocationDeniedView()
            }
        }
        .modelContainer(for: Destination.self)
        .environment(locationManager)
    }
}
