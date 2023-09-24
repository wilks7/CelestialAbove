//
//  StarNode.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 9/10/23.
//

import Foundation
import SceneKit

class StarNode: CelestialNode {
    let hyg: HYGStar

    init(star: HYGStar) {
        let color = Self.colorForStar(withCI: star.ci)
        let size = StarConfiguration.sizeForStar(magnitude: star.mag, distance: star.dist)
        let geometry = SCNSphere(radius: size)
        geometry.firstMaterial?.diffuse.contents = color
        geometry.firstMaterial?.emission.contents = color
        self.hyg = star
        let distance = StarConfiguration.parsecToScene(star.dist)

        super.init(name: star.name, coordinates: star.coordinates, distance: distance, magnitude: star.mag, size: size, color: color)
        self.geometry = geometry
        self.name = star.name
    }


    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension StarNode {
    static func colorForStar(withCI ci: Double?) -> UIColor {
        guard let ci else { return .white }
        switch ci {
        case ..<0:
            return UIColor.blue
        case 0..<0.6:
            return UIColor.systemTeal // or another blue-ish color
        case 0.6..<1.4:
            return UIColor.white
        case 1.4..<2.0:
            return UIColor.yellow
        default:
            return UIColor.red
        }
    }
}
