//
//  MockRestaurantClient.swift
//  4.RestroomFinder
//
//  Created by MANAS VIJAYWARGIYA on 24/12/24.
//

import Foundation

struct MockRestroomClient: HTTPClient {
  
  func fetchRestrooms(url: URL) async throws -> [Restroom] {
    return PreviewData.load(resourceName: "restrooms")
  }
  
}
