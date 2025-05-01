//
//  RingColors.swift
//  Sectional Rings
//
//  Created by Chuck Deerinck on 4/25/25.
//

import Foundation
import SwiftUI

struct RingColors {
    //green, green2yellow, yellow, yellow2red, 3 colors, 2 gradients
    var colors: [UIColor] = [UIColor.green.withAlphaComponent(0.3), UIColor.yellow.withAlphaComponent(0.3), UIColor.red.withAlphaComponent(0.3)]// Must be 3 of these
    var safety: [Double] = [0.999, 0.5, 0.4, 0.3, 0.2, 0.1] // Must be 6 of these each between 0 and <1.
    // that means we are green from 0% to 50%, green/yellow gradient from 50% to 70%, yellow from 70% to 80%, yellow/red from 80% to 90%, and red from 90% to 100%
    // rings 0, 2, 4 are solid, and rings 1 and 3 are gradients.
    var lOverD:Double = 50.0
    var patternAltitude:Double = 1000.0
    var pixelsPerNM:Double = 43.5 // True for LA Sectional at least
    var elevation:Double = 4000.0
}

func displayInfo(ring:RingColors) -> String {
    var str = "L/D : \(ring.lOverD)\n"
    str += "Pattern Altitude: \(ring.patternAltitude)\n"
    str += "Elevation: \(ring.elevation)\n"
    str += "Safety % : >\(ring.safety[1]*100), \(ring.safety[2]*100)%-\(ring.safety[3]*100)%, \(ring.safety[4]*100)%-\(ring.safety[5]*100)%\n"
    
    return str
}

