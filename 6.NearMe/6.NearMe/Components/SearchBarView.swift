//
//  SearchBarView.swift
//  6.NearMe
//
//  Created by MANAS VIJAYWARGIYA on 24/12/24.
//

import SwiftUI

struct SearchBarView: View {
  var placeholder: String = "Search"
  @Binding var search: String
  @Binding var isSearching: Bool
  @Binding var clearItem: Bool
  
  var body: some View {
    VStack(spacing: -10) {
      HStack(alignment: .center) {
        TextField(placeholder, text: $search)
          .textFieldStyle(.roundedBorder)
          .padding()
          .onSubmit {
            isSearching = true
            clearItem = false
          }
          .disabled(isSearching)
        if !search.isEmpty {
          Button {
            search = ""
            clearItem = true
          } label: {
            Image(systemName: "xmark.circle.fill").foregroundStyle(.gray)
          }
          .padding(.trailing, 10)
        }
      }
      SearchOptionsView(onSelected: { searchTerm in
        search = searchTerm
        isSearching = true
        clearItem = false
      }, isSearching: $isSearching)
      // .padding([.leading], 10)
      .padding([.bottom], 20)
    }
  }
}

#Preview {
  SearchBarView(search: .constant("Coffee"), isSearching: .constant(true), clearItem: .constant(false))
}

