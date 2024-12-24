//
//  HTTPClientKey.swift
//  4.RestroomFinder
//
//  Created by MANAS VIJAYWARGIYA on 24/12/24.
//

import Foundation
import SwiftUI

private struct HTTPClientKey: EnvironmentKey {
  static var defaultValue: HTTPClient = RestroomClient()
}

extension EnvironmentValues {
  
  var httpClient: HTTPClient {
    get { self[HTTPClientKey.self] }
    set { self[HTTPClientKey.self] = newValue }
  }
  
}

