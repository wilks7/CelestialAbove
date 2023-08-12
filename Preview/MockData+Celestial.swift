//
//  MockData+Celestial.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import Foundation
import SwiftAA
import CoreLocation

extension MockData {
    
    static let saturn: CelestialEvents = CelestialService().createEvent(for: Saturn.self, at: locationNY, in: timezoneNY)
    static let mars: CelestialEvents = CelestialService().createEvent(for: Mars.self, at: locationNY, in: timezoneNY)
    static let jupiter: CelestialEvents = CelestialService().createEvent(for: Jupiter.self, at: locationNY, in: timezoneNY)
    static let venus: CelestialEvents = CelestialService().createEvent(for: Venus.self, at: locationNY, in: timezoneNY)


}
