//
//  SkyManager.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 2/1/24.
//

import Foundation
import CoreLocation



@Observable
class SkyManager {
    
    static let shared = SkyManager()
    
    var skies: [SkyKey]
    
    private static let sharedDefaults: UserDefaults = UserDefaults(suiteName: "group.app.rifigy.CelestialAbove")!
    
    
    private init() {
        self.skies = Self.fetchSkies()
    }
    
    private static func fetchSkies() -> [SkyKey] {
        guard let data = sharedDefaults.data(forKey: "skies") else {return []}
        let skies = try? JSONDecoder().decode([SkyKey].self, from: data)
        return skies ?? []
    }
    
    @MainActor
    func add(sky: SkyKey) {
        skies.append(sky)
        try? save()
    }
    
    @MainActor
    func remove(sky: SkyKey) {
        skies.removeAll{ $0.id == sky.id }
        try? save()
    }
    
    private func save() throws {
        let data = try JSONEncoder().encode(skies)
        Self.sharedDefaults.setValue(data, forKey: "skies")
    }
}
extension SkyManager: SkyStorage {

    func sky(for id: SkyKey.ID) -> SkyKey? {
        skies.first{$0.id == id}
    }
    
    func skies(for identifiers: [SkyKey.ID]) -> [SkyKey] {
        return skies.filter{ identifiers.contains($0.id) }
    }
    
    func allSkies() -> [SkyKey] {
        skies
    }

}
