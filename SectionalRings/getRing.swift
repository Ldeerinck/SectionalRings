//
//  getRing.swift
//  SectionalRings
//
//  Created by Chuck Deerinck on 4/27/25.
//

import Foundation
import UIKit

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
