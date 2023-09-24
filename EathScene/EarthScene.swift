//
//  AstroScene.swift
//  SwiftAAScene
//
//  Created by Michael Wilkowski on 8/31/23.
//

import Foundation
import SceneKit
import SwiftAA
import CoreLocation

class EarthScene: SCNScene {
    
    let location: CLLocation

    let compass = CompassNode()

    var planets: [PlanetNode] = []
    var stars: [StarNode] = []
    var constellations: [ConstellationNode] = []
    let visibleStars: [HYGStar] = StarManager.shared.visible
    var constellationStars: [String:[StarNode]] = [:]

    var moon = CelestialNode(Moon.self, distance: 100, magnitude: 1, size: 3, color: .gray)
    var floor: SCNNode?
    

    var celestialNodes: [CelestialNode] {
        [moon] + planets + stars
    }

    init(observer: CLLocation)  {
        self.location = observer
        super.init()
        rootNode.addChildNode(compass.node)

        self.moon.updatePosition(at: .now, observer: observer)
        rootNode.addChildNode(self.moon)
        
        addFloor()
        addLight()
        createPlanets()
        createStars()
        handle(change: .now)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addFloor(){
        let circle = SCNCylinder(radius: 100, height: 0.5)
        circle.firstMaterial?.diffuse.contents = UIColor.green
        let circleNode = SCNNode(geometry: circle)
        circleNode.position = .init(x: 0, y: -1, z: 0)
        circleNode.opacity = 0.5
        self.floor = circleNode
        rootNode.addChildNode(self.floor!)

    }

    private func addLight(){
        let ambientLight = SCNLight()
        ambientLight.type = .ambient
        ambientLight.color = UIColor(white: 0.5, alpha: 1.0)
        let ambientNode = SCNNode()
        ambientNode.light = ambientLight
        rootNode.addChildNode(ambientNode)
    }
    func handle(change time: Date) {
        for star in stars {
            star.updatePosition(at: time, observer: location)
        }
        for planet in planets {
            planet.updatePosition(at: time, observer: location)
        }
        moon.updatePosition(at: time, observer: location)

    }
    
    func handle(change fov: CGFloat) {
        compass.updateCompass(for: fov)
        adjustStarVisibility(for: fov)
    }
    
    func handle(visibleNodes: [SCNNode]) {
        self.updatePlanetLabels(for: visibleNodes)
        self.updateStarLabels(for: visibleNodes)
        
    }
    
}

extension EarthScene {
    static var scale: CGFloat { 1 }
    
    static func createSphere(name: String, size radius: CGFloat = 1, color: NIColor = .white, at position: SCNVector3? = nil) -> SCNNode {
        let sphere = SCNSphere(radius: radius * scale)
        
        let mat = SCNMaterial()
        mat.locksAmbientWithDiffuse = true
        mat.diffuse.contents = color
        mat.selfIllumination.contents = UIColor.gray
        sphere.firstMaterial = mat

        let node = SCNNode(geometry: sphere)
        node.name = name
        if let position {
            node.position = SCNVector3(x: position.x, y: position.y, z: position.z * Float(scale))
        }
        return node
    }
    

}

func position(altitude: Double, azimuth: Double, distance: CGFloat, scale: CGFloat = 1) -> SCNVector3 {
    let distance = distance * scale
            
    let azimuthRadians = CGFloat((azimuth + 90) * (.pi / 180.0)) // Convert azimuth to radians and adjust by 90 degrees
    let altitudeRadians = CGFloat(altitude * (.pi / 180.0)) // Convert altitude to radians
    
    let x = distance * cos(azimuthRadians) * cos(altitudeRadians)
    let y = distance * sin(altitudeRadians) + 5 // 5 units above the SCNFloor
    let z = distance * sin(azimuthRadians) * cos(altitudeRadians)
    
    return SCNVector3(x, y, z)
}

extension SCNVector3 {
    static func +(lhs: SCNVector3, rhs: SCNVector3) -> SCNVector3 {
        return SCNVector3(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z)
    }
    
    static func -(lhs: SCNVector3, rhs: SCNVector3) -> SCNVector3 {
        return SCNVector3(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z)
    }
    
    static func *(lhs: SCNVector3, scalar: Float) -> SCNVector3 {
        return SCNVector3(lhs.x * scalar, lhs.y * scalar, lhs.z * scalar)
    }
    
    func length() -> Float {
        return sqrtf(x*x + y*y + z*z)
    }

    static func /(lhs: SCNVector3, scalar: Float) -> SCNVector3 {
        return SCNVector3(lhs.x / scalar, lhs.y / scalar, lhs.z / scalar)
    }

}



