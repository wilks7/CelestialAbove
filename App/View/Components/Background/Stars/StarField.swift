//
//  StarField.swift
//  SkyAbove
//
//  Created by Michael on 7/7/22.
//

import Foundation

class StarField {
    var stars = [Star]()
    let leftEdge = -50.0
    let rightEdge = 500.0
    var lastUpdate = Date.now

    init() {
        for _ in 1...200 {
            let x = Double.random(in: leftEdge...rightEdge)
            let y = Double.random(in: 0...600)
            let size = Double.random(in: 1...3)
            let star = Star(x: x, y: y, size: size)
            stars.append(star)
        }
    }

    func update(date: Date) {
        let delta = date.timeIntervalSince1970 - lastUpdate.timeIntervalSince1970

        for star in stars {
            star.x -= delta * 2

            if star.x < leftEdge {
                star.x = rightEdge
            }
        }

        lastUpdate = date
    }
    class Star {
        var x: Double
        var y: Double
        var size: Double
        var flickerInterval: Double

        init(x: Double, y: Double, size: Double) {
            self.x = x
            self.y = y
            self.size = size

            if size > 2 && y < 250 {
                flickerInterval = Double.random(in: 3...20)
            } else {
                flickerInterval = 0
            }
        }
    }

}
