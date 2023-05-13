//
//  Double.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import Foundation

extension Double {    
    var percent: Int? {
        let percentFormatter = NumberFormatter()
        percentFormatter.numberStyle = .percent
        percentFormatter.maximumFractionDigits = 0
        if let string = percentFormatter.string(for: self) {
            return Int(string.dropLast(1))
        } else {
            return nil
        }
    }
}
