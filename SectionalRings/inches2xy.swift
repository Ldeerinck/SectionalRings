//
//  inches2xy.swift
//  SectionalRings
//
//  Created by Chuck Deerinck on 4/29/25.
//

import Foundation

func inches2xy(left: Double, top:Double, size:CGSize) -> CGPoint {
    
    let width:Double = 55.54
    let height:Double = 41.35

    let x = (left / width) * size.width
    let y = (top / height) * size.height
    let spot:CGPoint = CGPoint(x:x, y:y)
    return spot
    
}
