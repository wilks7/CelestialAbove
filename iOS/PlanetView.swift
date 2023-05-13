//
//  PlanetView.swift
//  SkyAbove
//
//  Created by Michael Wilkowski on 4/10/23.
//

import SwiftUI
import SceneKit
import Foundation

struct PlanetView: View {
    let celestial: String
    let width: CGFloat
    let height: CGFloat
    var interactions: Bool = false
    
    init(celestial: String, width: CGFloat, height: CGFloat, interactions: Bool = true) {
        self.celestial = celestial
//        if celestial == "Saturn" {
//            self.width = width*2
//            self.height = height*2
//        } else {
//            self.width = width
//            self.height = height
//        }
        self.width = width
        self.height = height
        self.interactions = interactions
    }
    
    var body: some View {
        Group {
            #if os(watchOS)
            sceneView
            #else
            MySceneView(celestial: celestial, interactions: interactions)
            #endif
        }
        .frame(width: width, height: height, alignment: .center)
    }
    
    @ViewBuilder
    var sceneView: some View {
        let options: SceneView.Options = interactions ? [.autoenablesDefaultLighting, .allowsCameraControl] : [.autoenablesDefaultLighting]
        SceneView(
            scene: {
                var planetScene: SCNScene!

                if let scene = SCNScene(named: "\(celestial)_NASA.usdz") {
                    planetScene = scene
                } else if let scene = SCNScene(named: "\(celestial).usdz") {
                    planetScene = scene
                } else {
                    planetScene = SCNScene(named: "Earth.usdz")
                }
                planetScene.background.contents = UIColor.red.withAlphaComponent(0.6) /// here!
                return planetScene
            }(),
            options:options
        )
    }
}

#if !os(watchOS)
struct MySceneView: UIViewRepresentable {
    typealias Context = UIViewRepresentableContext<MySceneView>
    let celestial: String
    let interactions: Bool

    func updateUIView(_ uiView: SCNView, context: Context) {}
    func makeUIView(context: Context) -> SCNView {
        let view = SCNView()
        view.backgroundColor = UIColor.clear // this is key!
        view.allowsCameraControl = interactions
        view.autoenablesDefaultLighting = true
        // load the object here, could load a .scn file too
        if let scene = SCNScene(named: "\(celestial)_NASA.usdz") {
            view.scene = scene
        } else if let scene = SCNScene(named: "\(celestial).usdz") {
            view.scene = scene
        } else {
            view.scene = SCNScene(named: "Earth.usdz")
        }
        return view
    }
}
#endif

struct PlanetView_Previews: PreviewProvider {
    static var previews: some View {
        PlanetView(celestial: "Mars", width: 100, height: 100)
    }
}
