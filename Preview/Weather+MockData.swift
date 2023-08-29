//
//  Weather+MockData.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 8/28/23.
//

import Foundation
import WeatherKit


extension MockData {
    static var weather: Weather {
        loadJSON(file: "WeatherMockData")!
    }
}

extension MockData {
    static func loadJSON<T:Decodable>(file: String) -> T? {
        guard let path = Bundle.main.path(forResource: file, ofType: "json") else {
            print("No File")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let object = try JSONDecoder().decode(T.self, from: data)
            return object
        } catch {
            print(error)
            return nil
        }
    }
}
