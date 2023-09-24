//
//  CelestialNode.swift
//  SwiftAAScene
//
//  Created by Michael Wilkowski on 9/2/23.
//

import Foundation
import SceneKit
import SwiftAA
import CoreLocation
#if os(macOS)
typealias NIColor = NSColor
#else
typealias NIColor = UIColor
#endif

#if os(macOS)
typealias NIFont = NSFont
#else
typealias NIFont = NSFont
#endif

class CelestialNode: SCNNode, Identifiable {
    var id: String { celestialName }

    let celestialName: String
    let coordinates: EquatorialCoordinates
    let distance: CGFloat
    var magnitude: Double
    var size: CGFloat
    var color: NIColor
    
    var labelNode: SCNNode?
    
    var isLabelShown: Bool {
        return labelNode?.parent == self
    }
    

    init(name: String, 
         coordinates: EquatorialCoordinates,
         distance: CGFloat,
         magnitude: Double,
         size: CGFloat,
         color: NIColor = .white)
    {
        self.celestialName = name
        self.coordinates = coordinates
        self.magnitude = magnitude
        self.size = size
        self.color = color
        self.distance = distance
        super.init()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updatePosition(at date: Date, observer location: CLLocation) {

        let object = AstronomicalObject(name: celestialName, coordinates: coordinates, julianDay: .init(date), highPrecision: true)

        let location = GeographicCoordinates(location)
        let horizontal = object.makeHorizontalCoordinates(with: location)
        
        
        let altitude = horizontal.altitude.value
        let azimuth = horizontal.azimuth.value

                
        let azimuthRadians = CGFloat((azimuth + 90) * (.pi / 180.0)) // Convert azimuth to radians and adjust by 90 degrees
        let altitudeRadians = CGFloat(altitude * (.pi / 180.0)) // Convert altitude to radians
        
        let x = distance * cos(azimuthRadians) * cos(altitudeRadians)
        let y = distance * sin(altitudeRadians) // 5 units above the SCNFloor
        let z = distance * sin(azimuthRadians) * cos(altitudeRadians)
        
        self.position = SCNVector3(x, y, z)
    }
    
    func showLabel(_ color: NIColor = .white) {
        // Remove any existing label first
        labelNode?.removeFromParentNode()
        
        // Create an SCNText and assign properties
        let labelText = SCNText(string: celestialName, extrusionDepth: 1.0)
        labelText.font = NIFont.systemFont(ofSize: 24)
        
        // Create a node for the text
        labelNode = SCNNode(geometry: labelText)
        labelNode!.scale = SCNVector3(0.1, 0.1, 0.1) // adjust the scale
        labelNode!.position = SCNVector3(0, 0, 0) // position it above the planet
        
        
        // Add the billboard constraint
        let billboardConstraint = SCNBillboardConstraint()
        billboardConstraint.freeAxes = SCNBillboardAxis.Y // This allows the label to rotate around the Y-axis, always facing the camera
        labelNode!.constraints = [billboardConstraint]
        
        labelNode!.opacity = 0.0
        let fadeIn = SCNAction.fadeIn(duration: 1.0)
        labelNode!.runAction(fadeIn)
        
        
        addChildNode(labelNode!)
    }
    
    func hideLabel() {
        let fadeOut = SCNAction.fadeOut(duration: 1.0)
        labelNode?.runAction(fadeOut) {
            self.labelNode?.removeFromParentNode()
        }
    }
    
}

extension CelestialNode {
    convenience init<C:CelestialBody>(_ type: C.Type, distance: CGFloat, magnitude: Double, size: CGFloat, color: NIColor) {
        let body = C(julianDay: .init(.now), highPrecision: true)
        let geometry = SCNSphere(radius: size)
        geometry.firstMaterial?.diffuse.contents = color
        geometry.firstMaterial?.emission.contents = color
        self.init(name: body.name, coordinates: body.equatorialCoordinates, distance: distance, magnitude: magnitude, size: size, color: color)
        self.name = body.name
        self.geometry = geometry
    }

}

