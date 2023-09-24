//
//  StarManager.swift
//  SwiftAAScene
//
//  Created by Michael Wilkowski on 9/6/23.
//

import Foundation

class StarManager {
    let hygStars: [HYGStar]
    let visible: [HYGStar]
    static let shared = StarManager()

    private init() {
        self.hygStars = StarService.fetchStars()
        self.visible = self.hygStars.filter { star in
            let starDistance = star.dist ?? Double.infinity
            
            if star.mag < StarConfiguration.veryBrightMagnitude {
                return true
            } else if star.mag >= StarConfiguration.moderateMagnitude && star.mag <= StarConfiguration.fainterMagnitude {
                return starDistance <= StarConfiguration.maxStarDistance
            } else {
                return false
            }
        }
        print("[Star Manager] \(self.visible.count) Stars")
    }
}


struct StarConfiguration {
    // Magnitude thresholds
    static let veryBrightMagnitude: CGFloat = 0.0
    static let brightMagnitude: CGFloat = 2.5
    static let moderateMagnitude: CGFloat = 4.0
    static let faintMagnitude: CGFloat = 6.0
    static let fairlyFaintMagnitude: CGFloat = 7.0
    static let fainterMagnitude: CGFloat = 8.0
    static let moreFaintMagnitude: CGFloat = 9.0
    
    // Distance thresholds and values
    static let maxStarDistance: Double = 1000
    static let maxSceneDistance: CGFloat = 300
    static let minSceneDistance: CGFloat = 120
    
    // Size values
    static let defaultStarSize: CGFloat = 0.5
    static let minStarSize: CGFloat = 0.1
    
    static func parsecToScene(_ parsecs: Double?) -> CGFloat {
        let minSceneDistance = StarConfiguration.minSceneDistance
        let maxSceneDistance = StarConfiguration.maxSceneDistance

        guard let parsecs = parsecs else {
            return minSceneDistance
        }

        // Linear scaling based on the StarConfiguration values
        let minParsec: Double = 0
        let maxParsec: Double = StarConfiguration.maxStarDistance

        let scale = (maxSceneDistance - minSceneDistance) / CGFloat(maxParsec - minParsec)
        let sceneDistance = minSceneDistance + scale * CGFloat(parsecs - minParsec)

        return min(maxSceneDistance, max(minSceneDistance, sceneDistance))
    }
    
    
    static func sizeForStar(magnitude: Double, distance: Double?) -> CGFloat {
        let defaultSize = StarConfiguration.defaultStarSize
        let minSize = StarConfiguration.minStarSize
        
        // Scale size based on magnitude (brighter stars are larger)
        var sizeBasedOnMagnitude: CGFloat = defaultSize - CGFloat(magnitude) * 0.05
        sizeBasedOnMagnitude = max(sizeBasedOnMagnitude, minSize)  // Ensure it's not smaller than minSize
        
        // Scale size based on distance (closer stars are larger)
        let safeDistance = distance ?? Double.infinity
        var sizeBasedOnDistance: CGFloat = defaultSize
        if safeDistance <= 1000 {  // Closer stars
            sizeBasedOnDistance = defaultSize * 1.5
        }
        
        // Combine the two sizes by taking their average
        let combinedSize = (sizeBasedOnMagnitude + sizeBasedOnDistance) / 2.0
        return max(combinedSize, minSize)  // Ensure the final size is not smaller than minSize
    }

}
