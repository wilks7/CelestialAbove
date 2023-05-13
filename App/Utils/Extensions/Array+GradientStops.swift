//
//  Array+GradientStops.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/13/23.
//

import SwiftUI
import Foundation

extension Array where Element == Gradient.Stop {
    func interpolated(amount: Double) -> Color {
        guard let initialStop = self.first else {
            fatalError("Attempted to read color from empty stop array.")
        }

        var firstStop = initialStop
        var secondStop = initialStop

        for stop in self {
            if stop.location < amount {
                firstStop = stop
            } else {
                secondStop = stop
                break
            }
        }

        let totalDifference = secondStop.location - firstStop.location

        if totalDifference > 0 {
            let relativeDifference = (amount - firstStop.location) / totalDifference
            return firstStop.color.interpolated(to: secondStop.color, amount: relativeDifference)
        } else {
            return firstStop.color.interpolated(to: secondStop.color, amount: 0)
        }
    }
}


extension Color {
    func getComponents() -> (red: Double, green: Double, blue: Double, alpha: Double) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        
        #if os(macOS)
        let uiColor = NSColor(self)
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
        #else
        let uiColor = UIColor(self)
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
        #endif
    }

    func interpolated(to other: Color, amount: Double) -> Color {
        let componentsFrom = self.getComponents()
        let componentsTo = other.getComponents()

        let newRed = (1 - amount) * componentsFrom.red + (amount * componentsTo.red)
        let newGreen = (1 - amount) * componentsFrom.green + (amount * componentsTo.green)
        let newBlue = (1 - amount) * componentsFrom.blue + (amount * componentsTo.blue)
        let newOpacity = (1 - amount) * componentsFrom.alpha + (amount * componentsTo.alpha)

        return Color(.displayP3, red: newRed, green: newGreen, blue: newBlue, opacity: newOpacity)
    }
}
