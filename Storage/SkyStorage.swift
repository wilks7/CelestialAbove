//
//  SkyStorage.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 2/1/24.
//

import Foundation

protocol SkyStorage {
    associatedtype S:Identifiable
    func sky(for id: S.ID) -> S?
    func skies(for identifiers: [S.ID]) -> [S]
    func allSkies() -> [S]
}
