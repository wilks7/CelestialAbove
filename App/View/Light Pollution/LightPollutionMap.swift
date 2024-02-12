//
//  LightPollutionMapView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 8/27/23.
//

import SwiftUI
import MapKit


#if os(macOS)
typealias Representable = NSViewRepresentable
#else
typealias Representable = UIViewRepresentable
#endif

struct LightPollutionMap: Representable {
    func makeNSView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        let overlay = TileOverlay()
        mapView.addOverlay(overlay)
        let regionRadius: CLLocationDistance = 50000
        let location = location.coordinate//CLLocationCoordinate2D(latitude: 33.7490, longitude: -84.3880)
        let coordinateRegion = MKCoordinateRegion(
                                    center: location,
                                    latitudinalMeters: regionRadius * 2.0,
                                    longitudinalMeters: regionRadius * 2.0)
//
        mapView.setRegion(coordinateRegion, animated: false)
//        mapView.isUserInteractionEnabled = userIteractions
        return mapView
    }
    
    func updateNSView(_ nsView: MKMapView, context: Context) {
        
    }
    
    typealias NSViewType = MKMapView
    
    let location: CLLocation

    var mapStyle: MKMapType = .mutedStandard
    var userIteractions = false
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        let overlay = TileOverlay()
        mapView.addOverlay(overlay)
        let regionRadius: CLLocationDistance = 50000
        let location = location.coordinate//CLLocationCoordinate2D(latitude: 33.7490, longitude: -84.3880)
        let coordinateRegion = MKCoordinateRegion(
                                    center: location,
                                    latitudinalMeters: regionRadius * 2.0,
                                    longitudinalMeters: regionRadius * 2.0)
//
        mapView.setRegion(coordinateRegion, animated: false)
//        mapView.isUserInteractionEnabled = userIteractions
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        // Optional: Update configurations if needed
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: LightPollutionMap
        
        init(_ parent: LightPollutionMap) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if overlay is TileOverlay {
                return TileOverlayRenderer(overlay: overlay)
            }
            return MKOverlayRenderer(overlay: overlay)
        }
        

    }
}


#Preview {
    LightPollutionMap(location: MockData.locationNY)
}
