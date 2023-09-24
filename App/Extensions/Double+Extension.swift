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

}
