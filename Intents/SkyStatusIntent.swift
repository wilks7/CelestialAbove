//
//  SelectSkyIntent.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 10/4/23.
//

import SwiftUI
import AppIntents
import SwiftAA

struct SkyIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Sky"
    static var description = IntentDescription("Choose a night sky.")

    @Parameter(title: "Sky", optionsProvider: SkyQuery())
    var sky: SkyEntity
    
    @Parameter(title: "Planet")
    var planet: PlanetTime?
    
    @Parameter(title: "Display", default: .planet)
    var display: DisplayData
    
    init() {
        self.sky = SkyEntity.NewYork
    }
}

extension SkyIntent {
    static var newYork: SkyIntent {
        let intent = SkyIntent()
        intent.sky = .NewYork
        return intent
    }
}

enum DisplayData: String, AppEnum {
    case forecast, planet
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Display"
    static var caseDisplayRepresentations: [DisplayData : DisplayRepresentation] = [
        .forecast : .init(stringLiteral: "Forecast"),
        .planet : .init(stringLiteral: "Planet")
    ]

}

enum PlanetTime: String, AppEnum, CaseIterable {
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Planet"
    
    static var caseDisplayRepresentations: [PlanetTime : DisplayRepresentation] = [
        .mars : .init(stringLiteral: "Mars"),
        .venus : .init(stringLiteral: "Venus"),
        .saturn : .init(stringLiteral: "Saturn"),
        .jupiter : .init(stringLiteral: "Jupiter")
    ]
    
    case mars, venus, saturn, jupiter
    
    var celestial: Planet.Type {
        switch self {
        case .mars:
            Mars.self
        case .venus:
            Venus.self
        case .saturn:
            Saturn.self
        case .jupiter:
            Jupiter.self
        }
    }
}
