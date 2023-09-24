//
//  CameraCoordinator.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 9/6/23.
//

import Foundation
import SwiftUI
import SceneKit
import CoreMotion
import SwiftAA
//import ARKit


class CameraCoordinator: NSObject {
    @Binding var cameraEnabled: Bool
    @Binding var compassEnabled: Bool
    @Binding var selectedNode: CelestialNode?


    init(cameraEnabled: Binding<Bool>, compassEnabled: Binding<Bool>, selectedNode: Binding<CelestialNode?>){
        self._cameraEnabled = cameraEnabled
        self._compassEnabled = compassEnabled
        self._selectedNode = selectedNode
    }
    
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        guard let arScnView = sender.view as? ARSCNView else { return }
        let location = sender.location(in: arScnView)
        print("Tapped: \(location)")
        let hitResults = arScnView.hitTest(location, options: nil)
        if let celestialNode = hitResults.first?.node as? CelestialNode {
//            print("Celestial: \(celestialNode.details.name)")
            self.selectedNode = celestialNode
        }
    }


    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard let scnView = gestureRecognizer.view as? ARSCNView else { return }
        
        let translation = gestureRecognizer.translation(in: scnView)
        
        // Calculate the rotation angles based on the swipe distances
        let rotationAngleY = Float(translation.x) * 0.005 // Adjust the multiplier for sensitivity
        let rotationAngleX = Float(translation.y) * 0.005 // Adjust the multiplier for sensitivity
        
        // Calculate the new pitch angle based on the current angle and the desired rotation
        var newPitchAngle = (scnView.pointOfView?.eulerAngles.x ?? 0) + rotationAngleX
        
        // Limit the pitch angle to a range of -45 to 45 degrees
        newPitchAngle = max(-Float.pi / 2, min(newPitchAngle, Float.pi / 2))
        
        scnView.pointOfView?.eulerAngles.z = 0
        scnView.session.pause()
//        earthView.loadControl()
        if cameraEnabled {
            cameraEnabled = false
            compassEnabled = false
        }
        // Rotate the camera around the Y and set the new pitch angle
        scnView.pointOfView?.eulerAngles.y += rotationAngleY
        scnView.pointOfView?.eulerAngles.x = newPitchAngle

        gestureRecognizer.setTranslation(.zero, in: scnView)
    }
    
    @objc func handlePinch(_ recognizer: UIPinchGestureRecognizer) {
        guard let scnView = recognizer.view as? SCNView,
        let camera = scnView.pointOfView?.camera else { return }

        let pinchScale = CGFloat(recognizer.scale)
        var newFOV = camera.fieldOfView / pinchScale
        newFOV = max(MIN_FOV, min(MAX_FOV, newFOV))

        if recognizer.state == .began || recognizer.state == .changed {
            scnView.pointOfView?.camera?.fieldOfView = newFOV
            recognizer.scale = 1.0
        }
    }
}

enum SceneMode: String {
    case compass, camera, touch
}

