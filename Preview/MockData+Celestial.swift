//
//  MockData+Celestial.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import Foundation
import SwiftAA

extension MockData {
    static let saturn: CelestialEvents = CelestialService().fetchEvent(for: Saturn.self, at: locationNY, in: timezoneNY)
    static let mars: CelestialEvents = CelestialService().fetchEvent(for: Mars.self, at: locationNY, in: timezoneNY)
    static let jupiter: CelestialEvents = CelestialService().fetchEvent(for: Jupiter.self, at: locationNY, in: timezoneNY)
    static let venus: CelestialEvents = CelestialService().fetchEvent(for: Venus.self, at: locationNY, in: timezoneNY)


}
