//
//  RendererUpdatePublisher.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 9/12/23.
//

import Foundation
import Combine
import SceneKit
//import ARKit
import CoreLocation

import Combine

class SceneModel: NSObject, ObservableObject {
    @Published var time: Date = .now
    @Published var fieldOfView: CGFloat = 0.0
    @Published var cameraAngle: SCNVector3 = .init()
    
    let earthView: EarthSceneView
    let location: CLLocation
    private let scene: EarthScene
    private var lastUpdateTime: TimeInterval = 0.0
    private var timer: Timer?
    
    
    init(observer: CLLocation) {
        self.location = observer
        scene = EarthScene(observer: observer)
        earthView = EarthSceneView()
        earthView.scene = scene
        earthView.setCamera()
        super.init()
        earthView.delegate = self
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            if let newDate = Calendar.current.date(byAdding: .second, value: 1, to: self?.time ?? Date()) {
                self?.time = newDate
                
            }
        }
        
    }
    
    deinit {
        // Invalidate the timer when the object is deinitialized
        timer?.invalidate()
    }
    
    func compassChange(_ oldValue: Bool, newValue compassEnabled: Bool) {
        self.earthView.compassChange(oldValue, compassEnabled)
    }
    
    func cameraChange(_ oldValue: Bool, newValue cameraEnabled: Bool) {
        self.earthView.cameraChange(oldValue, cameraEnabled)
    }
    
    func handleChange(_ oldValue: Date, newValue time: Date) {
        self.scene.handle(change: time)
    }
}
extension SceneModel: ARSCNViewDelegate {

    func renderer(_ renderer: SCNSceneRenderer, didRenderScene scene: SCNScene, atTime time: TimeInterval) {
        guard let arView = renderer as? ARSCNView, let pointOfView = arView.pointOfView else { return }
        
        
        DispatchQueue.main.async {
            // Store values in temporary properties
            if let fov = pointOfView.camera?.fieldOfView, fov != self.fieldOfView {
                print("Setting FOV: \(fov)")
                self.fieldOfView = fov
                self.scene.handle(change: fov)
            }
            
            let angle = pointOfView.eulerAngles
            if angle != self.cameraAngle {
                print("Setting Angle: \(angle)")

                self.cameraAngle = angle
                self.earthView.updateFrustrum()


            }
            
        }
        
//
//        
//        if time - lastUpdateTime >= 1.0 {
//
//            print("FOV: \(fov)")
//            print("Angle: \(angle)")
//            
//            self.scene.handle(change: fov)
//            self.scene.handle(change: angle)
//
//              DispatchQueue.main.async {
//                  // Store values in temporary properties
//                  self.cameraAngle = pointOfView.eulerAngles
//                  self.fieldOfView = pointOfView.camera?.fieldOfView ?? 0.0
//                  
//              }
//              lastUpdateTime = time
//          }
//        

    }
}

