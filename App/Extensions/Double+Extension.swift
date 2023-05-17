//
//  Double.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import Foundation

extension Double {
    
    var percentString: String? {
        let percentFormatter = NumberFormatter()
        percentFormatter.numberStyle = .percent
        percentFormatter.maximumFractionDigits = 0
        return percentFormatter.string(for: self)
    }
    
    var percent: Int? {
        if let string = percentString {
            return Int(string.dropLast(1))
        } else {
            return nil
        }
    }
}
