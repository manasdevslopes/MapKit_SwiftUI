//
//  SearchOptionsView.swift
//  6.NearMe
//
//  Created by MANAS VIJAYWARGIYA on 24/12/24.
//

import SwiftUI

struct SearchOptionsView: View {
  let searchOptions =  ["Gas": "fuelpump.fill", "Restaurants": "fork.knife", "Hotels": "bed.double.fill", "Railway Stations": "train.side.front.car", "CNG Stations": "fuelpump.fill", "Parking": "parkingsign", "Coffee Shops": "cup.and.saucer.fill", "Bars": "wineglass.fill", "Pizza": "fork.knife", "Burgers": "fork.knife"]
  
  let onSelected: (String) -> Void
  @Binding var isSearching: Bool
  
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack {
        ForEach(Array(searchOptions.sorted(by: >).enumerated()), id: \.element.0) { index, keyValuePair in
          Button {
            onSelected(keyValuePair.key)
          } label: {
            HStack {
              Image(systemName: keyValuePair.value)
              Text(keyValuePair.key)
            }
          }
          .disabled(isSearching)
          .buttonStyle(.borderedProminent)
          .tint(Color(red: 236/255, green: 240/255, blue: 241/255, opacity: 1.0))
          .foregroundStyle(.black)
          // Apply -ve margin to the first and last elements
          .padding(.leading, index == 0 ? -6 : 0)
          .padding(.trailing, index == searchOptions.count - 1 ? -10 : 0)
          .padding(4)
        }
      }
      .padding(.horizontal, 20) // Apply padding here for initial side spacing
      .contentShape(Rectangle()) // Ensure the tappable area extends to the edges
    }
  }
}

#Preview {
  SearchOptionsView(onSelected: { _ in }, isSearching: .constant(false))
}
