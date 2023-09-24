//
//  Star.swift
//  SwiftAAScene
//
//  Created by Michael Wilkowski on 8/31/23.
//

import Foundation
import SwiftAA

public class Star: AstronomicalObject {
    public let magnitude: Double

    public var alternativeName: String?
    public var constellation: String?
    public var notes: String?
    
    public init(name: String,
                magnitude: Double,
                constellation: String? = nil,
                alternativeName: String? = nil,
                nebula: String? = nil,
                galaxy: String? = nil,
                notes: String? = nil,
                coordinates: EquatorialCoordinates,
                julianDay: JulianDay,
                highPrecision: Bool = true) {
        self.magnitude = magnitude
        self.constellation = constellation
        self.alternativeName = alternativeName
        self.constellation = constellation
        self.notes = notes
        super.init(name: name, coordinates: coordinates, julianDay: julianDay)
        
    }
    
    required init(julianDay: JulianDay, highPrecision: Bool) {
        fatalError("init(julianDay:highPrecision:) has not been implemented")
    }
}

public class Polaris: Star {
    public required init(julianDay: JulianDay, highPrecision: Bool = true) {
        let name = "Polaris"
        let magnitude = 1.97  // Approximate magnitude of Polaris
        let constellation = "Ursa Minor"  // Constellation where Polaris is located
        let coordinates = EquatorialCoordinates(
            rightAscension: Hour(.plus, 2, 31, 47.08),  // Right Ascension of Polaris
            declination: Degree(.plus, 89, 15, 50.8)   // Declination of Polaris
        )
        
        super.init(name: name, magnitude: magnitude, constellation: constellation, coordinates: coordinates, julianDay: julianDay, highPrecision: highPrecision)
    }
}



