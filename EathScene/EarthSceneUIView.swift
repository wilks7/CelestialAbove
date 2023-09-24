//
//  EarthSceneUIView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 9/6/23.
//

import Foundation
import SwiftUI
import SceneKit

struct EarthSceneUIView: UIViewRepresentable {
    typealias Coordinator = CameraCoordinator

    let arView: EarthSceneView
    @Binding var cameraEnabled: Bool
    @Binding var compassEnabled: Bool
    @Binding var selectedNode: CelestialNode?

    func makeUIView(context: Context) -> EarthSceneView {
        
        let config = ARWorldTrackingConfiguration()
        config.worldAlignment = .gravityAndHeading
        arView.session.run(config)
        arView.autoenablesDefaultLighting = true


        addGesutreRecognizers(to: arView, context: context)
        return arView
    }
    
    func updateUIView(_ arView: EarthSceneView, context: Context) {
        
    }

    
    func makeCoordinator() -> CameraCoordinator {
        CameraCoordinator(cameraEnabled: $cameraEnabled, compassEnabled: $compassEnabled, selectedNode: $selectedNode)
    }
    
    func addGesutreRecognizers(to scnView: SCNView, context: Context){
        let panRecognizer = UIPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePan(_:)))
        scnView.addGestureRecognizer(panRecognizer)
        
        let pinchRecognizer = UIPinchGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePinch(_:)))
        scnView.addGestureRecognizer(pinchRecognizer)
        
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleTap(sender:)))
        scnView.addGestureRecognizer(tapGesture)
    }
}

extension SCNVector3: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y && rhs.z == lhs.z
    }
}
