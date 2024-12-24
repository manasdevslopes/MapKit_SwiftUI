//
//  ActionButtons.swift
//  4.RestroomFinder
//
//  Created by MANAS VIJAYWARGIYA on 24/12/24.
//

import SwiftUI
import MapKit

struct ActionButtons: View {
  
  let mapItem: MKMapItem
  
    var body: some View {
      HStack {
        
        Button(action: {
          MKMapItem.openMaps(with: [mapItem])
        }, label: {
          HStack {
            HStack {
              Image(systemName: "car.circle.fill")
              Text("Take me there")
            }
          }
        }).buttonStyle(.bordered)
          .tint(.green)
        
        Spacer()
        
      }
    }
}
