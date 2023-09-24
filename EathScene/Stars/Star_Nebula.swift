//
//  Stars.swift
//  SwiftAAScene
//
//  Created by Michael Wilkowski on 8/31/23.
//

import Foundation
import SwiftAA


public class Alnitak: Star {
    public required init(julianDay: JulianDay, highPrecision: Bool = true) {
        let name = "Alnitak"
        let magnitude = 1.77
        let constellation = "Orion"
        let nebula = "Flame Nebula, Horsehead Nebula"
        let coordinates = EquatorialCoordinates(
            rightAscension: Hour(.plus, 5, 40, 45.5),
            declination: Degree(.minus, 1, 56, 34.0)
        )
        
        super.init(name: name, magnitude: magnitude, constellation: constellation, nebula: nebula, coordinates: coordinates, julianDay: julianDay, highPrecision: highPrecision)
    }
}

public class Antares: Star {
    public required init(julianDay: JulianDay, highPrecision: Bool = true) {
        let name = "Antares"
        let magnitude = 0.96
        let constellation = "Scorpius"
        let nebula = "Rho Ophiuchi cloud complex"
        let coordinates = EquatorialCoordinates(
            rightAscension: Hour(.plus, 16, 29, 24.4),
            declination: Degree(.minus, 26, 25, 55.0)
        )
        
        super.init(name: name, magnitude: magnitude, constellation: constellation, nebula: nebula, coordinates: coordinates, julianDay: julianDay, highPrecision: highPrecision)
    }
}

public class Sadr: Star {
    public required init(julianDay: JulianDay, highPrecision: Bool = true) {
        let name = "Sadr"
        let magnitude = 2.23
        let constellation = "Cygnus"
        let nebula = "Gamma Cygni Nebula"
        let coordinates = EquatorialCoordinates(
            rightAscension: Hour(.plus, 20, 22, 13.7),
            declination: Degree(.plus, 40, 15, 24.0)
        )
        
        super.init(name: name, magnitude: magnitude, constellation: constellation, nebula: nebula, coordinates: coordinates, julianDay: julianDay, highPrecision: highPrecision)
    }
}

public class Rigel: Star {
    public required init(julianDay: JulianDay, highPrecision: Bool = true) {
        let name = "Rigel"
        let magnitude = 0.13
        let constellation = "Orion"
        let nebula = "Witch Head Nebula"
        let coordinates = EquatorialCoordinates(
            rightAscension: Hour(.plus, 5, 14, 32.3),
            declination: Degree(.minus, 8, 12, 6.0)
        )
        
        super.init(name: name, magnitude: magnitude, constellation: constellation, nebula: nebula, coordinates: coordinates, julianDay: julianDay, highPrecision: highPrecision)
    }
}
