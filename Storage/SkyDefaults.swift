////
////  SkyDefaults.swift
////  CelestialAbove
////
////  Created by Michael Wilkowski on 10/5/23.
////
//
//import Foundation
//
//class SkyDefaults {
//    private static let sharedDefaults: UserDefaults = UserDefaults(suiteName: "group.app.rifigy.CelestialAbove")!
//    
//    static private func save(_ skies: [NightSky]) throws {
//        let data = try JSONEncoder().encode(skies)
//        sharedDefaults.setValue(data, forKey: "skies")
//    }
//    
//    static func skies() -> [NightSky] {
//        guard let data = sharedDefaults.data(forKey: "skies") else {return []}
//        let skies = try? JSONDecoder().decode([NightSky].self, from: data)
//        return skies ?? []
//    }
//    
//    static func skies(for identifiers: [String]) -> [NightSky] {
//        let skies = self.skies()
//        return skies.filter{ identifiers.contains($0.id) }
//    }
//    
//    static func add(_ sky: NightSky) {
//        var skies = skies()
//        skies.append(sky)
//        try? save(skies)
//        
//    }
//    
//    static func remove(_ sky: NightSky) throws {
//        var skies = self.skies()
//        skies = skies.filter { $0.id != sky.id }
//        try save(skies)
//    }
//
//    static func remove(id: String) throws {
//        var skies = self.skies()
//        skies = skies.filter { $0.id != id }
//        try save(skies)
//    }
//    
//    static func sky(named: String) -> NightSky? {
//        let skies = skies()
//        return skies.first{$0.title == named}
//    }
//    
//}
