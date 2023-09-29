//
//  Cloud.swift
//  SkyAbove
//
//  Created by Michael on 7/7/22.
//

import SwiftUI

class CloudSize {
    enum Thickness: CaseIterable {
        case none, thin, light, regular, thick, ultra
        
        static func from(_ clouds: Double) -> Thickness {
            switch clouds {
            case 0..<0.16:
                return Thickness.none
            case 0..<0.32:
                return Thickness.thin
            case 0..<0.48:
                return Thickness.light
            case 0..<0.64:
                return Thickness.regular
            case 0..<0.80:
                return Thickness.thick
            case 0..<1.0:
                return Thickness.ultra
            default: return Thickness.regular
            }
        }
    }

    var position: CGPoint
    let imageNumber: Int
    let speed = Double.random(in: 4...12)
    let scale: Double

    init(imageNumber: Int, scale: Double) {
        self.imageNumber = imageNumber
        self.scale = scale

        let startX = Double.random(in: -400...400)
        let startY = Double.random(in: -50...200)
        position = CGPoint(x: startX, y: startY)
    }
}
