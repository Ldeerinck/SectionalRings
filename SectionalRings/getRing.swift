//
//  getRing.swift
//  SectionalRings
//
//  Created by Chuck Deerinck on 4/27/25.
//

import Foundation
import UIKit

func getRing(landable:Landable, ringSegment:Int, rings:RingColors) -> (insideColor:UIColor, outsideColor:UIColor, insideRadius:Double, outsideRadius:Double, gradient:Bool)
{
    //ringSegment=0 is green up to idx=4 = red
    // 0=green, 1=green/yellow, 2=yellow, 3=yellow/red, 4=red
    let baseColor:Int = ringSegment / 2
    let outsideFeetPerNM:Double = (6000 / rings.lOverD) / (1.0 - rings.safety[ringSegment+1])
    //let insideRadius:Double = (height - (Double(landable.elev) + rings.patternAltitude)) / insideFeetPerNM * rings.pixelsPerNM
    let toSpare = (rings.elevation - (Double(landable.elev) + rings.patternAltitude))
    var outsideRadius:Double = (rings.elevation - (Double(landable.elev) + rings.patternAltitude)) / outsideFeetPerNM * rings.pixelsPerNM
    var insideRadius:Double = 0 // 0 is the default for the innermost ring
    if outsideRadius < 0 { outsideRadius = 0 }
    if insideRadius < 0 { insideRadius = 0 }
    if ringSegment != 0 {
        let insideFeetPerNM:Double = (6000 / rings.lOverD) / (1.0 - rings.safety[ringSegment])
        insideRadius = (rings.elevation - (Double(landable.elev) + rings.patternAltitude)) / insideFeetPerNM * rings.pixelsPerNM
    }
    //print(landable.name, ringSegment, toSpare, outsideFeetPerNM, outsideRadius / rings.pixelsPerNM, outsideRadius)
    if ringSegment%2 == 0 {
        return (insideColor: rings.colors[baseColor], outsideColor: rings.colors[baseColor], insideRadius:insideRadius, outsideRadius:outsideRadius, gradient:false)
    } else {
        return (insideColor: rings.colors[baseColor], outsideColor: rings.colors[baseColor+1], insideRadius:insideRadius, outsideRadius:outsideRadius, gradient:true)
    }
}
