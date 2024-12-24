//
//  ActionButtons.swift
//  6.NearMe
//
//  Created by MANAS VIJAYWARGIYA on 24/12/24.
//

import SwiftUI
import MapKit

struct ActionButtons: View {
  let mapItem: MKMapItem
  let showDirection: () -> ()
  let directionCount: Int
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        if let phone = mapItem.phoneNumber {
          Button {
            let numericPhoneNumber = phone.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            makeCall(phone: numericPhoneNumber)
          } label: {
            HStack {
              Image(systemName: "phone.fill")
              Text("Call")
            }
          }.buttonStyle(.bordered)
        }
        
        Button {
          openAppleMaps(destination: mapItem)
        } label: {
          HStack {
            Image(systemName: "car.circle.fill")
            Text("Take me there")
          }
        }.buttonStyle(.bordered).tint(.green)
        
        Spacer()
      }
      
      Button {
        showDirection()
      } label: {
        HStack {
          Image(systemName: "arrow.triangle.turn.up.right.diamond.fill")
          Text("Show Direction")
        }
      }
      .disabled(directionCount == 0)
      .buttonStyle(.bordered).tint(.blue)
    }
  }
}

#Preview {
  ActionButtons(mapItem: PreviewData.apple, showDirection: { }, directionCount: 0)
}

