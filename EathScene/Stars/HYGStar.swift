//
//  HYGStar.swift
//  SwiftAAScene
//
//  Created by Michael Wilkowski on 9/1/23.
//

import Foundation
import SwiftAA

struct HYGStar: Identifiable {
    let id: Int
    let hip: Int?
    let hd: Int?
    let hr: Int?
    let gl: String?
    let bf: String?
    let proper: String?
    let ra: Double
    let dec: Double
    let dist: Double?
    let pmra: Double?
    let pmdec: Double?
    let rv: Double?
    let mag: Double
    let absmag: Double?
    let spect: String?
    let ci: Double?
    let x: Double?
    let y: Double?
    let z: Double?
    let vx: Double?
    let vy: Double?
    let vz: Double?
    let rarad: Double
    let decrad: Double
    let pmrarad: Double?
    let pmdecrad: Double?
    let bayer: String?
    let flam: Int?
    let con: String?
    let comp: Int?
    let comp_primary: Int?
    let base: String?
    let lum: Double?
    let variable: String?
    let var_min: Double?
    let var_max: Double?
    
    
    var name: String {
        if let proper {
            return proper
        } else if let hd {
            return "HD \(hd)"
        } else if let hip {
            return "HIP \(hip)"
        } else {
            return "HYG \(id)"
        }
    }

}

extension HYGStar {
    init?(columns: [String]) {
        guard columns.count == 37 else {
            return nil
        }
        
        guard let id = Int(columns[0]),
              let mag = Double(columns[13]),
                let ra = Double(columns[7]),
                let dec = Double(columns[8]),
              let x = Double(columns[17]),
              let y = Double(columns[18]),
              let z = Double(columns[19]),
              let rarad = Double(columns[23]),
              let decrad = Double(columns[24])
        else {
            return nil
        }
        
        self.init(
            id: id,
            hip: Int(columns[1]),
            hd: Int(columns[2]),
            hr: Int(columns[3]),
            gl: columns[4],
            bf: columns[5],
            proper: columns[6],
            ra: ra,
            dec: dec,
            dist: Double(columns[9]),
            pmra: Double(columns[10]),
            pmdec: Double(columns[11]),
            rv: Double(columns[12]),
            mag: mag,
            absmag: Double(columns[14]),
            spect: columns[15],
            ci: Double(columns[16]),
            x: x,
            y: y,
            z: z,
            vx: Double(columns[20]),
            vy: Double(columns[21]),
            vz: Double(columns[22]),
            rarad: rarad,
            decrad: decrad,
            pmrarad: Double(columns[25]),
            pmdecrad: Double(columns[26]),
            bayer: columns[27],
            flam: Int(columns[28]),
            con: columns[29],
            comp: Int(columns[30]) ?? 0,
            comp_primary: Int(columns[31]) ?? 0,
            base: columns[32],
            lum: Double(columns[33]) ?? 0.0,
            variable: columns[34],
            var_min: Double(columns[35]),
            var_max: Double(columns[36])
        )
    }
    
    var coordinates: EquatorialCoordinates {

        // Convert degrees to hours for rightAscension and degrees for declination
        let rightAscension = Hour(ra)
        let declination = Degree(dec)

        // Now you can use the extracted values to initialize EquatorialCoordinates
         return EquatorialCoordinates(
            rightAscension: rightAscension,
            declination: declination
        )
    }
}


//
//extension Star {
//    convenience init(hygStar: HYGStar, julianDay: JulianDay, highPrecision: Bool = true) {
////        self.magnitude = hygStar.mag
////        self.constellation = hygStar.con
////        self.alternativeName = hygStar.bayer
////        self.notes = hygStar.variable
////
//        let coordinates = EquatorialCoordinates(
//            rightAscension: Hour(hygStar.rarad),
//            declination: Degree(hygStar.decrad)
//        )
//        self.init(name: hygStar.name, magnitude: hygStar.mag, constellation: hygStar.con, alternativeName: hygStar.bayer, notes: hygStar.variable, coordinates: coordinates, julianDay: julianDay, highPrecision: highPrecision)
//        
////        super.init(name: hygStar.proper, coordinates: coordinates, julianDay: julianDay)
//    }
//}
