////
////  ARKitView.swift
////  SwiftAAScene
////
////  Created by Michael Wilkowski on 9/5/23.
////
//
//import SwiftUI
//import ARKit
//
//struct ARSCNKitView: UIViewRepresentable {
//    typealias Coordinator = GestureCoordinator
//    let scnView = ARSCNView()
//    let manager: EarthManager
//    let configuration = ARWorldTrackingConfiguration()
//
//    @Binding var fov: CGFloat
//    @Binding var time: Date
//    @Binding var cameraAngle: SCNVector3
//    @Binding var cameraEnabled: Bool
//    @Binding var selectedNode: SCNNode?
//
//    func makeUIView(context: Context) -> ARSCNView {
////        scnView.delegate = context.coordinator
//        // Set up ARSession configuration (e.g., ARWorldTrackingConfiguration)
//        configuration.worldAlignment = .gravityAndHeading
////        scnView.backgroundColor = .black
//        scnView.session.run(configuration)
//
//        scnView.scene = manager.scene
//        addGesutreRecognizers(to: scnView, context: context)
//
//        return scnView
//    }
//    
//    func updateUIView(_ uiView: ARSCNView, context: Context) {
//        if manager.originalSource == nil {
//            manager.originalSource = scnView.scene.background.contents
//        }
//        print(selectedNode)
//        manager.handle(change: cameraEnabled)
//        scnView.pointOfView?.camera?.fieldOfView = fov
//        manager.handle(change: time)
//        manager.handle(change: fov)
//
//    }
//    
//    func makeCoordinator() -> GestureCoordinator {
//        GestureCoordinator(selectedNode: $selectedNode)
//    }
//    
//    func addGesutreRecognizers(to scnView: SCNView, context: Context){
//        let panRecognizer = UIPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePan(_:)))
//        scnView.addGestureRecognizer(panRecognizer)
//        
//        let pinchRecognizer = UIPinchGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePinch(_:)))
//        scnView.addGestureRecognizer(pinchRecognizer)
//        
//        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(sender:)))
//        scnView.addGestureRecognizer(tapGesture)
//    }
//
//}
