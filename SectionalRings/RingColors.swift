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
    var safety: [Double] = [0.0, 0.5, 0.7, 0.8, 0.9, 1.0]// Must be 5 of these each between 0 and 1.
    // that means we are green from 0% to 50%, green/yellow gradient from 50% to 70%, yellow from 70% to 80%, yellow/red from 80% to 90%, and red from 90% to 100%
    // rings 0, 2, 4 are solid, and rings 1 and 3 are gradients.
    var lOverD:Double = 50.0
    var patternAltitude:Double = 1000.0
    var pixelsPerNM = 435.0 // True for LA Sectional at least
}

func getRing(height: Double, landable:Landable, ringSegment:Int, rings:RingColors) -> (insideColor:UIColor, outsideColor:UIColor, insideRadius:Double, outsideRadius:Double, gradient:Bool)
{
    //ringSegment=0 is green up to idx=4 = red
    // 0=green, 1=green/yellow, 2=yellow, 3=yellow/red, 4=red
    let base:Int = ringSegment / 2
    let insideFeetPerNM:Double = (6000 / rings.lOverD) * (1.0 - rings.safety[base])
    let outsideFeetPerNM:Double = (6000 / rings.lOverD) * (1.0 - rings.safety[base+1])
    let insideRadius:Double = (height - (Double(landable.elev) + rings.patternAltitude)) * insideFeetPerNM * rings.pixelsPerNM
    let outsideRadius:Double = (height - (Double(landable.elev) + rings.patternAltitude)) * outsideFeetPerNM * rings.pixelsPerNM
    if ringSegment%2 == 0 {
        return (insideColor: rings.colors[base*2], outsideColor: rings.colors[base*2], insideRadius:insideRadius, outsideRadius:outsideRadius, gradient:false)
    } else {
        return (insideColor: rings.colors[base*2], outsideColor: rings.colors[base*2+1], insideRadius:insideRadius, outsideRadius:outsideRadius, gradient:true)
    }
}
