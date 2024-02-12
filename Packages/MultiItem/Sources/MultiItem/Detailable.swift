//
//  Detailable.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 10/4/23.
//

import Foundation

public protocol Detailable {
    var detail: String {get}
    var subdetail: String? {get}
    
    var info: String {get}
    var subinfo: String? {get}
    
    var description: [String:String] {get}
}
public extension Detailable {
    var subdetail: String? {nil}
    
    var description: [String:String] { [:] }
}
