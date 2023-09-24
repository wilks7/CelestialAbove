//
//  StarService.swift
//  SwiftAAScene
//
//  Created by Michael Wilkowski on 9/1/23.
//


import Foundation

class StarService {
    enum Error: Swift.Error { case noFile }
    
    private static func readCSVFile() throws -> String {
        guard let filePath = Bundle.main.path(forResource: "hygdata_v3", ofType: "csv") else {
            throw Error.noFile
        }
        let fileContents = try String(contentsOfFile: filePath)
        return fileContents
    }

    static func fetchStars() -> [HYGStar] {
        do {
            let csvString = try readCSVFile()
            
            let rows = csvString.components(separatedBy: "\n")
//            let header = rows[0].components(separatedBy: ",")
            var stars: [HYGStar] = []

            for row in rows[1...] {
                let columns = row.components(separatedBy: ",")
                if columns.count != 37 {
                    continue
                }
                
                if let star = HYGStar(columns: columns) {
                    stars.append(star)
                }
            }

            return stars
        } catch {
            print(error)
            return []
        }
    }
    
    static func fetchStarsDict() -> [Int:HYGStar] {
        do {
            let csvString = try readCSVFile()
            
            let rows = csvString.components(separatedBy: "\n")
            let header = rows[0].components(separatedBy: ",")
            var stars: [Int:HYGStar] = [:]

            for row in rows[1...] {
                let columns = row.components(separatedBy: ",")
                if columns.count != 37 {
                    continue
                }
                
                if let star = HYGStar(columns: columns) {
                    stars[star.id] = star
                }
            }

            return stars
        } catch {
            print(error)
            return [:]
        }
    }

}







protocol StarCoordinate {
    var id: Int {get}
    var x: Double {get}
    var y: Double {get}
    var z: Double {get}
}
//
//extension StarService {
//    
//    static func makeSpheres(from: [Int:HYGStar]) -> [SCNNode] {
//        var nodes: [SCNNode] = []
//        for star in from.values {
//            if star.dist < 50 {
//                let sphere = makeSphere(for: star)
//                nodes.append(sphere)
//            }
//        }
//        return nodes
//    }
//    
//    static func makeSphere(for star: any StarCoordinate) -> SCNNode {
//        let sphere = SCNSphere(radius: 0.01)
//        let node = SCNNode(geometry: sphere)
//        let scale: CGFloat = 5
//        
//        let arX = CGFloat(star.x) / scale
//        let arY = CGFloat(star.y) / scale
//        let arZ = CGFloat(star.z) / scale
//        
//        print("\n-------------\n")
//        print("Cartesian: x:\(star.x), y:\(star.y), z:\(star.z)")
//        print("\n-------------\n")
//        
//        print("\n-------------\n")
//        print("AR: x:\(arX), y:\(arY), z:\(arZ)")
//        print("\n-------------\n")
//        
//        node.name = String(star.id)
//        
//        node.position = .init(arX, arY, arZ)
//        node.geometry?.firstMaterial?.diffuse.contents = UIColor.gray
//        return node
//    }
//}
