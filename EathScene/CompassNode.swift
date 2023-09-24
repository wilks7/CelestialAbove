//
//  CompassNode.swift
//  SwiftAAScene
//
//  Created by Michael Wilkowski on 9/4/23.
//

import Foundation
import SceneKit

class CompassNode {
    let node = SCNNode()
    
    init(){
        addCompass()
    }
    
    private var northNode = SCNNode()
    private var southNode = SCNNode()
    private var eastNode = SCNNode()
    private var westNode = SCNNode()
    private var ringNode = SCNNode()
    
    // MARK: - Constants
    private var originalPipeRadius: CGFloat { 0.5 }
    private var originalFov: CGFloat { START_FOV }
    private var referenceFOV: CGFloat { START_FOV }
    private var circleRadius: CGFloat { 100 }
    private var textFontSize: CGFloat { 24 }
    private var textScale: SCNVector3 { SCNVector3(0.1, 0.1, 0.1) }
    
    // MARK: - Computed Properties
    private var scaleForFOV: CGFloat {
        return originalFov / referenceFOV
    }
    
    // MARK: - Compass Methods
    private func addCompass(for fov: CGFloat = START_FOV) {
        let scale = scaleForFOV
        
        ringNode = createRingNode(radius: circleRadius, pipeRadius: originalPipeRadius)
        northNode = createDirectionTextNode("N", position: SCNVector3(0, 0, -circleRadius))
        southNode = createDirectionTextNode("S", position: SCNVector3(0, 0, circleRadius), rotation: SCNVector3(x: 0, y: .pi, z: 0))
        eastNode = createDirectionTextNode("E", position: SCNVector3(circleRadius, 0, 0), rotation: SCNVector3(x: 0, y: -.pi / 2, z: 0))
        westNode = createDirectionTextNode("W", position: SCNVector3(-circleRadius, 0, 0), rotation: SCNVector3(x: 0, y: .pi / 2, z: 0))

        for n in [ringNode, northNode, southNode, eastNode, westNode] {
            node.addChildNode(n)
        }
//        scene.rootNode.addChildNode(compassNode)
    }
    
    private func createRingNode(radius: CGFloat, pipeRadius: CGFloat) -> SCNNode {
        let ring = SCNTorus(ringRadius: radius, pipeRadius: pipeRadius)
        return SCNNode(geometry: ring)
    }
    
    private func createDirectionTextNode(_ text: String, position: SCNVector3, rotation: SCNVector3 = SCNVector3Zero) -> SCNNode {
        let textGeometry = SCNText(string: text, extrusionDepth: 0.1)
        textGeometry.font = UIFont.systemFont(ofSize: textFontSize)
        textGeometry.firstMaterial?.diffuse.contents = UIColor.white
        
        let textNode = SCNNode(geometry: textGeometry)
        textNode.position = position
        textNode.eulerAngles = rotation
        textNode.scale = textScale
        
        return textNode
    }
    
    func updateCompass(for fov: CGFloat) {
        let scale = scaleForFOV
        updateRingPipeRadius(for: fov)
        updateTextSize(for: fov)
        //        compassNode.scale(to: scale)
    }
    
    private func updateRingPipeRadius(for fov: CGFloat) {
        if let torus = ringNode.geometry as? SCNTorus {
            let t = (fov - MIN_FOV) / (MAX_FOV - MIN_FOV)
            let minPipeRadius = 0.1 * originalPipeRadius
            torus.pipeRadius = lerp(a: minPipeRadius, b: originalPipeRadius, t: t)
        }
    }
    
    private func updateTextSize(for fov: CGFloat) {
        // Calculate the scale factor based on the FOV
        let scale = originalFov / fov
//
//        // Adjust the font size of the text nodes
//        let adjustedFontSize = textFontSize * scale
//        [northNode, southNode, eastNode, westNode].forEach { node in
//            if let text = node.geometry as? SCNText {
//                text.font = UIFont.systemFont(ofSize: adjustedFontSize)
//            }
//        }
        
        // Adjust the distance of the text nodes from the camera
        let adjustedRadius = circleRadius * scale
        northNode.position = SCNVector3(0, 0, -adjustedRadius)
        southNode.position = SCNVector3(0, 0, adjustedRadius)
        eastNode.position = SCNVector3(adjustedRadius, 0, 0)
        westNode.position = SCNVector3(-adjustedRadius, 0, 0)
    }


    
    // MARK: - Utility Methods
    private func lerp(a: CGFloat, b: CGFloat, t: CGFloat) -> CGFloat {
        return a + (b - a) * t
    }

    

}
// MARK: - Utility Methods
func lerp(a: CGFloat, b: CGFloat, t: CGFloat) -> CGFloat {
    return a + (b - a) * t
}
