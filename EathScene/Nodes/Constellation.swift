//
//  Constellation.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 9/11/23.
//

import Foundation
import SceneKit

struct Constellation: Hashable {
    let name: String
    let hdPattern: [Int]

    static let Orion: Constellation = {
        let orionPattern = [
            37742,  // Alnitak
            39801,  // Betelgeuse
            36861,  // Ori A
            35468,  // Bellatrix
            36486,  // Mintaka
            37128,  // Alnilam
            37742,  // Alnitak
            37742,   // Saiph
            34085,  // Rigel
            36486  // Mintaka

        ]
        return Constellation(name: "Orion", hdPattern: orionPattern)
    }()
}
extension Constellation {
    static func containingStar(withHD hd: Int?) -> Constellation? {
        guard let hd else {return nil}
        if Orion.hdPattern.contains(hd) {
            return Orion
        }
        // You'd repeat similar checks for other constellations here...

        return nil
    }
}


class ConstellationNode: SCNNode {
    var constellation: Constellation
    var starNodes: [StarNode]
    
    init(constellation: Constellation, _ nodes: [StarNode]) {
        self.starNodes = nodes
        self.constellation = constellation
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addStarNode(_ star: StarNode) {
        starNodes.append(star)
    }
    
    func drawLines() {
        guard starNodes.count > 3 else { return }

        // Now, loop through these ordered stars and draw lines between them.
        for i in 0..<starNodes.count - 1 {
            let startStar = starNodes[i]
            let endStar = starNodes[i + 1]
            drawLine(from: startStar.position, to: endStar.position)
        }
    }

    
    private func drawLine(from start: SCNVector3, to end: SCNVector3) {
        let vector = end - start
        let length = vector.length()
        let cylinder = SCNCylinder(radius: 1, height: CGFloat(length))
        cylinder.radialSegmentCount = 8 // Adjust for smoother cylinders
        
        let node = SCNNode(geometry: cylinder)
        
        node.position = (start + end) / 2.0
        node.look(at: end, up: SCNVector3(0, 1, 0), localFront: SCNVector3(0, 0, 1))
        
        let mat = SCNMaterial()
        mat.diffuse.contents = UIColor.red
        cylinder.firstMaterial = mat
        
        addChildNode(node)
    }
}
