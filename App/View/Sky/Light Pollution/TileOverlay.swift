import Foundation
import MapKit

let MAX_ZOOM = 6
let TILE_SIZE: Double = 1024

func zoomScaleToZoomLevel(_ scale: MKZoomScale) -> Int {
    let numTilesAt1_0 = MKMapSize.world.width / TILE_SIZE
    let zoomLevelAt1_0 = log2(numTilesAt1_0)
    return Int(max(0, zoomLevelAt1_0 + floor(Double(log2f(Float(scale))) + 0.5)))
}

class TileOverlay: MKTileOverlay {
    
    override func url(forTilePath path: MKTileOverlayPath) -> URL {
        if let fileURL = Bundle.main.url(forResource: "tile_\(path.z)_\(path.x)_\(path.y)", withExtension: ".png") {
            return fileURL
        } else {
            // Consider using a default or placeholder image.
            return Bundle.main.url(forResource: "tile_\(4)_\(1)_\(5)", withExtension: ".png")!
        }
    }
    
    func tiles(in rect: MKMapRect, zoomScale scale: MKZoomScale) -> [ImageTile]? {
        var z = zoomScaleToZoomLevel(scale)
        
        var overZoom = 1
        if z > MAX_ZOOM {
            overZoom = Int(pow(2, Double(z - MAX_ZOOM)))
            z = MAX_ZOOM
        }
        
        let adjustedTileSize = overZoom * Int(TILE_SIZE)
        
        let minX = Int(floor((rect.minX * Double(scale)) / Double(adjustedTileSize)))
        let maxX = Int(floor((rect.maxX * Double(scale)) / Double(adjustedTileSize)))
        let minY = Int(floor((rect.minY * Double(scale)) / Double(adjustedTileSize)))
        let maxY = Int(floor((rect.maxY * Double(scale)) / Double(adjustedTileSize)))
        
        var tiles: [ImageTile] = []
        
        for x in minX...maxX {
            for y in minY...maxY {
                if let url = Bundle.main.url(forResource: "tile_\(z)_\(x)_\(y)", withExtension: ".png") {
                    let frame = MKMapRect(
                        x: Double(x * adjustedTileSize) / Double(scale),
                        y: Double(y * adjustedTileSize) / Double(scale),
                        width: Double(adjustedTileSize) / scale,
                        height: Double(adjustedTileSize) / scale)
                    tiles.append(ImageTile(frame: frame, path: url.absoluteString))
                }
            }
        }
        return tiles.isEmpty ? nil : tiles
    }
}

struct ImageTile {
    let frame: MKMapRect
    let path: String
}

class TileOverlayRenderer: MKOverlayRenderer {
    override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {
        let z = zoomScaleToZoomLevel(zoomScale)
        var overZoom = 1
        if z > MAX_ZOOM {
            overZoom = Int(pow(2, Double(z - MAX_ZOOM)))
        }
        
        let tileOverlay = overlay as? TileOverlay
        guard let tilesInRect = tileOverlay?.tiles(in: mapRect, zoomScale: zoomScale) else { return }
        
        context.setAlpha(0.5)
        
        for tile in tilesInRect {
            let rect = self.rect(for: tile.frame)
            if let imageData = try? Data(contentsOf: URL(string: tile.path)!),
               let image = UIImage(data: imageData),
               let cgImage = image.cgImage {
                
                context.saveGState()
                context.translateBy(x: rect.minX, y: rect.minY)
                context.scaleBy(x: CGFloat(CGFloat(overZoom) / zoomScale), y: CGFloat(CGFloat(overZoom) / zoomScale))
                context.translateBy(x: 0, y: image.size.height)
                context.scaleBy(x: 1, y: -1)
                context.draw(cgImage, in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
                context.restoreGState()
            }
        }
    }
}
