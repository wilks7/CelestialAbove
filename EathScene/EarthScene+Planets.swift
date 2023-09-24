//
//  EarthScene+Planets.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 9/11/23.
//

import Foundation
import SceneKit
import SwiftAA

extension EarthScene {
    func createPlanets(){
        let mars = PlanetNode(Mars.self, size: 3, color: .red)
        let saturn = PlanetNode(Saturn.self, size: 2, color: .orange)
        let venus = PlanetNode(Venus.self, size: 2.3, color: .blue)
        let jupiter = PlanetNode(Jupiter.self, size: 3, color: .cyan)
        
        self.planets = [mars, saturn, venus, jupiter]
        for planet in planets {
            planet.updatePosition(at: .now, observer: location)
            rootNode.addChildNode(planet)
        }
//        let line = createLineBetween(node1: jupiter, node2: saturn)
//        rootNode.addChildNode(line)
    }
    
    func updatePlanetLabels(for visibleNodes: [SCNNode]) {
        // Create a set of visible planets
        var visiblePlanets = Set<PlanetNode>()
        for node in visibleNodes {
            if let planet = self.planets.first(where: { node.isDescendant(of: $0) }) {
                visiblePlanets.insert(planet)
            }
        }
        
        // Update labels for each planet
        for planet in self.planets {
            if visiblePlanets.contains(planet) {
                if !planet.isLabelShown {
                    planet.showLabel()
                }
            } else if planet.isLabelShown {
                planet.hideLabel()
            }
        }
    }
}
