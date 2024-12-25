//
//  SampleParisLocation.swift
//  MyTrips
//
//  Created by MANAS VIJAYWARGIYA on 25/12/24.
//

import CoreLocation

// Sample Paris Location
extension CLLocationCoordinate2D {
    static let moulinRouge: Self = .init(
        latitude: 48.884134,
        longitude: 2.332196
    )
    
    static let eiffelTower: Self = .init(
        latitude: 48.858258,
        longitude: 2.294488
    )
    
    static let arcDeTriomphe: Self = .init(
        latitude: 48.873776,
        longitude: 2.295043
    )
    static let gareDuNord: Self = .init(
        latitude: 48.880071,
        longitude: 2.354977
    )
    static let louvre: Self = .init(
        latitude: 48.861950,
        longitude: 2.336902
    )
    static let sacreCoeur: Self = .init(
        latitude: 48.886634,
        longitude: 2.343048
    )
    static let notreDame: Self = .init(
        latitude: 48.852972,
        longitude: 2.350004
    )
    static let pantheon: Self = .init(
        latitude: 48.845616,
        longitude: 2.345996
    )
}

extension Array where Element == CLLocationCoordinate2D {
  static var paris: [CLLocationCoordinate2D] {
    return [CLLocationCoordinate2D(latitude: 48.886634, longitude: 2.343048), CLLocationCoordinate2D(latitude: 48.873776, longitude: 2.295043), CLLocationCoordinate2D(latitude: 48.858258, longitude: 2.294488), CLLocationCoordinate2D(latitude: 48.845616, longitude: 2.345996), CLLocationCoordinate2D(latitude: 48.852972, longitude: 2.350004), CLLocationCoordinate2D(latitude: 48.861950, longitude: 2.336902), CLLocationCoordinate2D(latitude: 48.880071, longitude: 2.354977),  CLLocationCoordinate2D(latitude: 48.884134, longitude: 2.332196)]
  }
}
