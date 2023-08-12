//
//  MockData+Sky.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import CoreData
import CoreLocation


extension MockData {
    
    static func NY() -> Sky {
        Sky(title: "New York", timezone: TimeZone(identifier: "America/New_York")!, location: .init(latitude: 40.7831, longitude: -73.9712))
    }
    
    static func LA() -> Sky {
        Sky(title: "Los Angeles", timezone: TimeZone(identifier: "America/Los_Angeles")!, location: .init(latitude: 34.0522, longitude: -118.2437))
    }

    static func MI() -> Sky {
        Sky(title: "Milan", timezone: TimeZone(identifier: "Europe/Rome")!, location: .init(latitude: 45.4642, longitude: 9.1900))
    }

    static func JA() -> Sky {
        Sky(title: "Jerusalem", timezone: TimeZone(identifier: "Asia/Jerusalem")!, location: .init(latitude: 31.7683, longitude: 35.2137))
    }

    static func TO() -> Sky {
        Sky(title: "Tokyo", timezone: TimeZone(identifier: "Asia/Tokyo")!, location: .init(latitude: 35.6762, longitude: 139.6503))
    }

    static func QT() -> Sky {
        Sky(title: "Queenstown", timezone: TimeZone(identifier: "Pacific/Auckland")!, location: .init(latitude: -45.0302, longitude: 168.6615))
    }
    
}
