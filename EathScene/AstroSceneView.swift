//
//  AstroSceneView.swift
//  SwiftAAScene
//
//  Created by Michael Wilkowski on 9/2/23.
//

import SwiftUI
import SceneKit
import CoreLocation

struct AstroSceneView: View {
    @Environment(\.dismiss) var dismiss
//    @State var time: Date = .now
    @State var cameraEnabled = false
    @State var compassEnabled = false
    @State var selectedNode: CelestialNode?
    
    @State private var showDetail = false
    @StateObject var model: SceneModel
    
    
    var body: some View {
        ZStack {
            EarthSceneUIView(arView: model.earthView,
                             cameraEnabled: $cameraEnabled,
                             compassEnabled: $compassEnabled,
                             selectedNode: $selectedNode
            )
            .ignoresSafeArea()
            VStack {
                HStack {
                    Button(systemName: "xmark") {
                        dismiss()
                    }
                    .font(.title)
                    .foregroundStyle(Color.white)
                    Spacer()
                }
                Spacer()
                HStack {
                    Spacer()
                    if compassEnabled {
                        ControlButton(enabled: $cameraEnabled, systemName: "camera") {
                            cameraEnabled.toggle()
                            if cameraEnabled, !compassEnabled {
                                compassEnabled = true
                            }
                        }
                    }
                }
                HStack {
                    Spacer()

                    TimeControl(time: $model.time)
                    ControlButton(enabled: $compassEnabled, systemName: "compass.drawing") {
                        compassEnabled.toggle()
                        if !compassEnabled, cameraEnabled {
                            cameraEnabled = false
                        }
                    }
                }
            }
            .font(.headline)
            .padding()

        }
        .onChange(of: compassEnabled, model.compassChange)
        .onChange(of: cameraEnabled, model.cameraChange)
        .onChange(of: model.time, model.handleChange)
        .onAppear {
            model.earthView.saveSoure()
            model.earthView.loadControl()
        }
        .sheet(item: $selectedNode) {
            self.selectedNode = nil
        } content: { celestialNode in
            Group {
                if let planetNode = celestialNode as? PlanetNode {
                    let body = planetNode.type.init(julianDay: .init(.now), highPrecision: true)
                    PlanetDetailsView(planet: body, location: model.location)

                } else if let starNode = celestialNode as? StarNode {
                    HYGStarDetailsView(star: starNode.hyg, location: model.location)
                } else {
                    VStack {
                        Text(celestialNode.name ?? "Name")
                    }
                }
            }

            .presentationDetents([.medium, .large])

        }

    }
}

extension AstroSceneView {
    
    struct ControlButton: View {
        @Binding var enabled: Bool
        let systemName: String
        let action: ()->Void
        
        var body: some View {
            Button(systemName: systemName, action: action)
            .foregroundStyle(enabled ? Color.red : Color.white)
            .padding()
            .transparent(cornderRadius: 16)
        }
    }
}

#Preview {
    AstroSceneView(model: .init(observer: CLLocation(latitude: 40.7081, longitude: -73.9571)))
}
