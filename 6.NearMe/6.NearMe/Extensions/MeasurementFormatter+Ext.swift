//
//  MeasurementFormatter+Ext.swift
//  6.NearMe
//
//  Created by MANAS VIJAYWARGIYA on 24/12/24.
//

import Foundation

extension MeasurementFormatter {
  static var distance: MeasurementFormatter {
    let formatter = MeasurementFormatter()
    formatter.unitStyle = .medium
    formatter.unitOptions = .naturalScale
    formatter.locale = Locale.current
    return formatter
  }
}
