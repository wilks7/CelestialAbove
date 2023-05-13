//
//  CoreLocation+Extension.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import CoreLocation

extension CLLocation {
    var id: String { "\(coordinate.latitude),\(coordinate.longitude)" }
}
