//
//  EarthScene+Stars.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 9/11/23.
//

import Foundation
import SwiftAA
import SceneKit

extension EarthScene {
    

    func createStars() {        
        for star in self.visibleStars {
            let node = StarNode(star: star)
            node.updatePosition(at: .now, observer: location)
            self.rootNode.addChildNode(node)
            self.stars.append(node)
        }
    }
    
    func updateStarLabels(for visibleNodes: [SCNNode]) {
        // Create a set of visible planets

        let stars = visibleNodes.compactMap{ $0 as? StarNode }
        
        // Update labels for each planet
        for node in stars {
            if let name = node.name, !name.isEmpty {
                if !node.isLabelShown {
                    node.showLabel()
                }
            } else if node.isLabelShown {
                node.hideLabel()
            }
        }
    }

    
    struct BrightnessThreshold {
        let veryBright: CGFloat = 0.0
        let bright: CGFloat = 2.5
        let moderate: CGFloat = 4.0
        let faint: CGFloat = 6.0
        let fairlyFaint: CGFloat = 7.0
        let fainter: CGFloat = 8.0
        let moreFaint: CGFloat = 9.0
    }
    
    func adjustStarVisibility(for fovDegrees: CGFloat) {
        typealias config = StarConfiguration  // For brevity

        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.5  // Assuming 0.5s as animation duration
        
        let fovFraction = 1.0 - (fovDegrees - MIN_FOV) / (MAX_FOV - MIN_FOV) // It will be close to 1 when FOV is at its minimum and close to 0 when FOV is at its maximum
            
        let minVisibleMagnitude = 2 + fovFraction * 3  // Starts at 2 when fovFraction is 0 and ends at 5 when fovFraction is 1
        let maxVisibleMagnitude = 5 + fovFraction * 3  // Starts at 5 when fovFraction is 0 and ends at 8 when fovFraction is 1

        for starNode in stars {
            let mag = starNode.magnitude
            if mag >= minVisibleMagnitude && mag <= maxVisibleMagnitude {
                starNode.opacity = 1.0
            } else {
                starNode.opacity = 0.0
            }
        }
        
        SCNTransaction.commit()
    }






    
}


// MARK: Constellations
extension EarthScene {
    
    
    func drawConstellations() {
        var constellationStarsMap: [Constellation: [StarNode]] = [:]

        for star in stars {
            if let constellation = Constellation.containingStar(withHD: star.hyg.hd) {
                constellationStarsMap[constellation, default: [StarNode]()].append(star)
            }
        }
        for (constellation, starNodes) in constellationStarsMap {
            guard starNodes.count > 3 else { return }
            print("STARS: \(starNodes.count)")

            // Now, loop through these ordered stars and draw lines between them.
            for i in 0..<starNodes.count - 1 {
                let startStar = starNodes[i]
                let endStar = starNodes[i + 1]
                self.drawLine(from: startStar.position, to: endStar.position)
            }
//                let constellationNode = ConstellationNode(constellation: constellation, starNodes)
//                constellationNode.drawLines()
//                constellationNodes.append(constellationNode)
        }
    }
    
    func createCylinderBetween(node1: SCNNode, node2: SCNNode, radius: CGFloat = 1) -> SCNNode {
        let vector = node2.position - node1.position
        let length = vector.length()
        let cylinder = SCNCylinder(radius: radius, height: CGFloat(length))
        cylinder.radialSegmentCount = 8 // You can adjust this for smoother cylinders
        
        let node = SCNNode(geometry: cylinder)
        
        // Position the cylinder node midway between the two nodes
        node.position = (node1.position + node2.position) / 2.0
        
        // Point the cylinder node at the second node
        node.look(at: node2.position, up: SCNVector3(0, 1, 0), localFront: SCNVector3(0, 1, 0))
        
        let mat = SCNMaterial()
        mat.diffuse.contents = UIColor.red
        cylinder.firstMaterial = mat
        
        return node
    }
    
    func createLineBetween(node1: SCNNode, node2: SCNNode) -> SCNNode {
        var coord1 = node1.position
        var coord2 = node2.position

        let diff = coord2 - coord1
        coord1 = coord1 + diff * 0.05
        coord2 = coord2 - diff * 0.05

        let vertexSources = SCNGeometrySource(vertices: [coord1, coord2])
        let elements = SCNGeometryElement(indices: [CInt(0), CInt(1)], primitiveType: .line)
        let lineGeo = SCNGeometry(sources: [vertexSources], elements: [elements])

        let mat = SCNMaterial()
        mat.diffuse.contents = UIColor.red
        mat.locksAmbientWithDiffuse = true
        lineGeo.firstMaterial = mat

        return SCNNode(geometry: lineGeo)
    }
    
    func drawLine(from start: SCNVector3, to end: SCNVector3) {

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
        
        self.rootNode.addChildNode(node)
    }
}
