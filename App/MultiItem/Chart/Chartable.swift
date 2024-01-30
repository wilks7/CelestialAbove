//
//  Chartable.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 10/4/23.
//

import Foundation
import Charts


protocol Chartable {
    associatedtype X: Plottable, Comparable, Hashable
    associatedtype Y: Plottable, Comparable, Hashable
    
    associatedtype PointFor = (X) -> Y
    
    var points: [(X,Y)] {get}
}

