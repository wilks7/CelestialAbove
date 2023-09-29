//
//  DebugService.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import Foundation
import os

protocol DebugLog {
    static var emoji: String { get }
    var name: String { get }
}

extension DebugLog {
    var name: String {
        String(describing: Self.self)
    }
    
    public var logger: Logger {
        Logger(subsystem: Bundle.main.bundleIdentifier!, category: name)
    }

}
