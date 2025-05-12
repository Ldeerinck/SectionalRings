//
//  drawInto.swift
//  Sectional Rings
//
//  Created by Chuck Deerinck on 4/23/25.
//

import Foundation
import SwiftUI

func drawRings(image:UIImage, globalSettings:Globals, landables:Landables) -> UIImage {
    
    UIGraphicsBeginImageContext(image.size)
    
    image.draw(at: CGPoint.zero) //draw image into context
    let context = UIGraphicsGetCurrentContext()!
    let rect:CGRect = CGRect(x: 1651.31, y: 1340.91, width: 14981.69, height: 10750.0)
    let colorSpace = CGColorSpace(name: CGColorSpace.sRGB)
    //settings for gradient is not used
    context.setLineWidth(2.0)
    context.setStrokeColor(UIColor.red.cgColor)
    context.setLineWidth(5.0)
    
    print(displayInfo(ring:Globals()))
    
    var step:Int = 1
    if !globalSettings.useGradients { step = 2 }
    for ringIndex in stride(from: 0, through: 4, by: step) {
        for item in landables.landables.filter({ $0.useable }) {
            let point = CGPoint(x: item.pixelX, y: item.pixelY) //inches2xy(left: item.tiffX, top: item.tiffY, size: image.size)
            let ring = getRing(landable: item, ringSegment: ringIndex, rings: globalSettings)
            let circle = CGRect(origin: CGPoint(x: point.x - ring.outsideRadius, y: point.y - ring.outsideRadius), size: CGSize(width: ring.outsideRadius*2, height:ring.outsideRadius*2))
            if(ring.gradient){
                context.saveGState()
                let mygrad:CGGradient = CGGradient(colorsSpace: colorSpace!, colors: [ring.insideColor.cgColor, ring.outsideColor.cgColor] as CFArray, locations: [0.0, 1.0])! //(between: color1, and: color2)
                context.addEllipse(in: circle )
                context.clip(using: CGPathFillRule.evenOdd)
                context.drawRadialGradient(mygrad, startCenter: point, startRadius:    ring.insideRadius, endCenter: point, endRadius: ring.outsideRadius, options: [.drawsAfterEndLocation])
                context.restoreGState()
                context.addEllipse(in: circle ) //This adds circle to the mask
                context.addRect(rect)
                context.clip(using: CGPathFillRule.evenOdd)
            }
            else {
                context.setFillColor(ring.insideColor.cgColor)
                context.addEllipse(in: circle )
                context.drawPath(using: .fill)
                context.addEllipse(in: circle) //This adds circle to the mask
                context.addRect(rect)
                context.clip(using: CGPathFillRule.evenOdd)
            }
            //saveFile(image: UIGraphicsGetImageFromCurrentImageContext()!, suffix: "\(ringIndex)-\(item.name)")
            //print("\(ringIndex)-\(item.name)")
        }
    }
    let myImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return myImage!
}

