//
//  Stars.swift
//  SwiftAAScene
//
//  Created by Michael Wilkowski on 8/31/23.
//

import Foundation
import SwiftAA

protocol StarDetails {
    var altName: String? {get}
    var magnitude: Double {get}
    var contellation: String? {get}
    var notes: String? {get}
}


public class Sirius: Star {
    public required init(julianDay: JulianDay, highPrecision: Bool = true) {
        let name = "Sirius"
        let magnitude = -1.46
        let constellation = "Canis Major"
        let coordinates = EquatorialCoordinates(
            rightAscension: Hour(.plus, 6, 45, 8.9),
            declination: Degree(.minus, 16, 42, 58.0)
        )
        
        super.init(name: name, magnitude: magnitude, constellation: constellation, coordinates: coordinates, julianDay: julianDay, highPrecision: highPrecision)
    }
}

public class Vega: Star {
    public required init(julianDay: JulianDay, highPrecision: Bool = true) {
        let name = "Vega"
        let magnitude = 0.03
        let constellation = "Lyra"
        let coordinates = EquatorialCoordinates(
            rightAscension: Hour(.plus, 18, 36, 56.3),
            declination: Degree(.plus, 38, 47, 1.0)
        )
        
        super.init(name: name, magnitude: magnitude, constellation: constellation, coordinates: coordinates, julianDay: julianDay, highPrecision: highPrecision)
    }
}

public class Deneb: Star {
    public required init(julianDay: JulianDay, highPrecision: Bool = true) {
        let name = "Deneb"
        let magnitude = 1.25
        let constellation = "Cygnus"
        let coordinates = EquatorialCoordinates(
            rightAscension: Hour(.plus, 20, 41, 25.9),
            declination: Degree(.plus, 45, 16, 49.0)
        )
        
        super.init(name: name, magnitude: magnitude, constellation: constellation, coordinates: coordinates, julianDay: julianDay, highPrecision: highPrecision)
    }
}

public class Altair: Star {
    public required init(julianDay: JulianDay, highPrecision: Bool = true) {
        let name = "Altair"
        let magnitude = 0.77
        let constellation = "Aquila"
        let coordinates = EquatorialCoordinates(
            rightAscension: Hour(.plus, 19, 50, 47.0),
            declination: Degree(.plus, 8, 52, 6.0)
        )
        
        super.init(name: name, magnitude: magnitude, constellation: constellation, coordinates: coordinates, julianDay: julianDay, highPrecision: highPrecision)
    }
}

public class Arcturus: Star {
    public required init(julianDay: JulianDay, highPrecision: Bool = true) {
        let name = "Arcturus"
        let magnitude = -0.04
        let constellation = "Boötes"
        let coordinates = EquatorialCoordinates(
            rightAscension: Hour(.plus, 14, 15, 39.7),
            declination: Degree(.plus, 19, 10, 56.0)
        )
        
        super.init(name: name, magnitude: magnitude, constellation: constellation, coordinates: coordinates, julianDay: julianDay, highPrecision: highPrecision)
    }
}

public class Capella: Star {
    public required init(julianDay: JulianDay, highPrecision: Bool = true) {
        let name = "Capella"
        let magnitude = 0.08
        let constellation = "Auriga"
        let coordinates = EquatorialCoordinates(
            rightAscension: Hour(.plus, 5, 16, 41.4),
            declination: Degree(.plus, 45, 59, 53.0)
        )
        
        super.init(name: name, magnitude: magnitude, constellation: constellation, coordinates: coordinates, julianDay: julianDay, highPrecision: highPrecision)
    }
}
