//
//  EventService.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 8/26/23.
//

import Foundation

enum EventType: String { case rise, set, transit }

class EventService {
    
    func nextEvent<E:Events>(for events: E, from now: Date = .now, sunrise: Date?, sunset: Date?) -> (date: Date?, type: EventType) {
        if let sunrise, let sunset {
            if now < sunrise {
                return (sunrise, .rise)
            } else if now < sunset {
                return (sunset, .set)
            } else {
                return (sunrise, .rise)
            }
        } else {
            return (nil, .transit)
        }
    }

}
