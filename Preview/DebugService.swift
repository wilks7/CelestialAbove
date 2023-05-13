//
//  DebugService.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import Foundation

protocol DebugPrint {
    static var emoji: String { get }
    static var name: String { get }
}
extension DebugPrint {
    static var name: String {
        String(describing: Self.self)
    }
}

extension DebugPrint {
    static func print(_ string: String = "", error: Error? = nil){
        let emoji = error != nil ? "⚠️" : emoji
                
        Swift.print("\(emoji) " + string + (error?.localizedDescription ?? "") )
    }
    
    
    func print(_ string: String = "", error: Error? = nil){
        Self.print(string, error: error)
    }
    
    func print(_ error: Error? = nil) {
        print("", error: error)
    }
}
