//
//  EarthSceneView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 9/10/23.
//

import Foundation
import ARKit
import SwiftUI
import SceneKit

class EarthSceneView: ARSCNView {
    var originalSource: Any? = nil
    var arCameraNode: SCNNode? = nil

    var cameraNode = SCNNode()
    
    func setCamera(){
        cameraNode.name = "Center_Node"
        cameraNode.position = .init(x: 0, y: 0, z: 0)
        cameraNode.camera = SCNCamera()
        cameraNode.camera?.name = "Center_Camera"
        cameraNode.camera?.fieldOfView = START_FOV
        cameraNode.camera?.zNear = 0.001
        cameraNode.camera?.zFar = 10000
        scene.rootNode.addChildNode(cameraNode)
    }

    
    func startSession(){
        let config = ARWorldTrackingConfiguration()
        config.worldAlignment = .gravityAndHeading
        session.run(config)
    }
    func compassChange(_ oldValue: Bool, _ newValue: Bool) {
        if newValue {
            loadARmotion()
        } else {
            loadControl()
        }
    }
    
    func cameraChange(_ oldValue: Bool, _ newValue: Bool) {
        if newValue {
            loadARcamera()
        } 
//        else if compassEnabled {
//            loadARmotion()
//        }
        else {
            loadControl()
        }
    }
    
    func saveSoure(){
        if originalSource == nil {
            print("Camera Feed Saved")
            originalSource = scene.background.contents
        }
        if arCameraNode == nil {
            print("Camera Node Saved")
            arCameraNode = pointOfView
        }
    }
    
    func loadARcamera(){
        scene.background.contents = UIColor.black
        pointOfView = arCameraNode

        let config = ARWorldTrackingConfiguration()
        config.worldAlignment = .gravityAndHeading
        session.run(config)
    }

    func loadARmotion(){
        let config = ARWorldTrackingConfiguration()
        config.worldAlignment = .gravityAndHeading
        session.run(config)
        pointOfView = arCameraNode
        scene.background.contents = originalSource
    }
    
    func loadControl(){
        session.pause()
        scene.background.contents = UIColor.black
        if let pointOfView {
            cameraNode.eulerAngles.y = pointOfView.eulerAngles.y
            cameraNode.eulerAngles.x = pointOfView.eulerAngles.x
        }
        pointOfView = cameraNode
    }
    
    func updateFrustrum() {
        guard let pointOfView = self.pointOfView else { return }
        let visibleNodes = self.nodesInsideFrustum(of: pointOfView)
        if let scene = scene as? EarthScene {
            scene.handle(visibleNodes: visibleNodes)
        }
    }
    
    func centerBox() -> CGRect {
        let view = self
        let width = view.bounds.width * 0.5
        let height = view.bounds.height * 0.5
        let originX = (view.bounds.width - width) / 2
        let originY = (view.bounds.height - height) / 2
        return CGRect(x: originX, y: originY, width: width, height: height)
    }
}

extension SCNNode {
    func isDescendant(of parent: SCNNode) -> Bool {
        var node: SCNNode? = self
        while let currentNode = node {
            if currentNode == parent {
                return true
            }
            node = currentNode.parent
        }
        return false
    }
}
