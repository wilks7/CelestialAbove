//
//  PlanetNode.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 9/10/23.
//

import Foundation
import SceneKit
import SwiftAA

class PlanetNode: CelestialNode {
    
    let type: Planet.Type
    var usdzNode: SCNNode?


    init<P:Planet>(_ type: P.Type, size: CGFloat, color: UIColor) {
        let body = P(julianDay: .init(.now), highPrecision: true)
        let sphere = SCNSphere(radius: size)
        sphere.firstMaterial?.emission.contents = color
        self.type = P.self
        super.init(name:body.name, coordinates: body.equatorialCoordinates, distance: 100, magnitude: 1, size: size, color: color)
        self.geometry = sphere
//        loadUsdz(named: body.name)
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadUsdz(named name: String){
        if let usdzURL = Bundle.main.url(forResource: "\(name)_NASA", withExtension: "usdz"),
           let referenceNode = SCNReferenceNode(url: usdzURL) {
            referenceNode.load()
            referenceNode.scale = .init(x: 0.005, y: 0.005, z: 0.005)
            self.usdzNode = referenceNode
            self.usdzNode!.name = name + "_usdz"
            addChildNode(self.usdzNode!)
        }
    }
    
    

}
