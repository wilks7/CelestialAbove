//
//  PlanetDetailsView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 9/12/23.
//

import SwiftUI
import SwiftAA
import CoreLocation

struct PlanetDetailsView: View {
    let planet: Planet
    let location: CLLocation
    
    @State var viewType: ViewType = .properties
    var body: some View {
        VStack {
            Text(planet.name)
            Text("Planet")
            PlanetView(celestial: planet.name)
            Picker("", selection: $viewType) {
                ForEach(ViewType.allCases) {
                    Text($0.title)
                        .tag($0)
                }
            }
            .pickerStyle(.segmented)
            switch viewType {
            case .properties:
                VStack {
                    Text("Observed")
                        .font(.headline)
                    Grid {
                        GridRow {
                            Text("Magnitude")
                            Text(planet.magnitude.value.description)
                        }
                        GridRow {
                            Text("Diameter")
                            Text((try? planet.polarSemiDiameter().value.description) ?? "")
                        }
                        GridRow {
                            Text("Distance")
                            Text(planet.trueGeocentricDistance.value.description + "AU")
                        }
                    }
                }
            case .visibility:
                VStack {
                    Text("Visibility")
                        .font(.headline)
                    Grid {
                        GridRow {
                            Text("Rises")
                            Text(planet.riseTransitSetTimes(for: .init(location)).riseTime?.value.formatted() ?? "Time")
                        }
                        GridRow {
                            Text("Transits")
                            Text(planet.riseTransitSetTimes(for: .init(location)).transitTime?.value.formatted() ?? "Time")
                        }
                        GridRow {
                            Text("Sets")
                            Text(planet.riseTransitSetTimes(for: .init(location)).setTime?.value.formatted() ?? "Time")
                        }
                    }
                }
            case .details:
                VStack {
                    Text("Details")
                        .font(.headline)
                }
            }
        }
    }
    
    enum ViewType: String, CaseIterable, Identifiable {
        case properties, visibility, details
        var id: String { rawValue }
        var title: String {
            rawValue.capitalized
        }
    }
}

//#Preview {
//    CelestialDetailsView(details: .init(name: "Mars", coordinates: .init(rightAscension: .zero, declination: .zero), distance: 30))
//}
