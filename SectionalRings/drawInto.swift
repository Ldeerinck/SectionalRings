//
//  drawInto.swift
//  Sectional Rings
//
//  Created by Chuck Deerinck on 4/23/25.
//

import Foundation
import SwiftUI

func goodBytesPerRow(_ width: CGFloat) -> CGFloat {
    return floor(((width * 4) + 15) / 16) * 16
}

func drawInto(image:UIImage) -> UIImage {
    
    UIGraphicsBeginImageContext(image.size)
    
    image.draw(at: CGPoint.zero) //Copy the sectional onto the new image
    let context = UIGraphicsGetCurrentContext()!
    
//    let z0 = getRing(height: 5000, landable: landables[5], ringSegment: 0, rings: RingColors())
//    let z1 = getRing(height: 5000, landable: landables[5], ringSegment: 1, rings: RingColors())

    //Not needed with all gradients
    context.setLineWidth(2.0)
    context.setStrokeColor(UIColor.red.cgColor)
    context.setLineWidth(5.0)
    
    let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: image.size)
    let circle1 = CGRect(origin: CGPoint(x: 16645.0 / 2 - 150, y: 12349.0 / 2 - 150), size: CGSize(width: 300, height:300))
    let circle2 = CGRect(origin: CGPoint(x: 16645.0 / 2 - 200, y: 12349.0 / 2), size: CGSize(width: 200, height:200))
    let circle3 = CGRect(origin: CGPoint(x: 16645.0 / 2 - 100, y: 12349.0 / 2 + 100), size: CGSize(width: 200, height:200))
    
//    //Solid circle
//    context.setFillColor(UIColor.green.cgColor)
//    context.setAlpha(0.25)
//    context.addEllipse(in: circle1)
//    context.drawPath(using: .fillStroke)
    
    let colorSpace = CGColorSpace(name: CGColorSpace.sRGB)
    let color1 = UIColor.green.withAlphaComponent(0.3)
    let color2 = UIColor.red.withAlphaComponent(0.3)
    
    context.saveGState()
    let mygrad:CGGradient = CGGradient(colorsSpace: colorSpace!, colors: [color1.cgColor, color2.cgColor] as CFArray, locations: [0.0, 1.0])!   //(between: color1, and: color2)
    context.addEllipse(in: circle1 )
    context.clip(using: CGPathFillRule.evenOdd)
    context.drawRadialGradient(mygrad, startCenter: CGPoint(x: 16645.0 / 2, y: 12349.0 / 2), startRadius: 0.0, endCenter: CGPoint(x: 16645.0 / 2, y: 12349.0 / 2), endRadius: 150.0, options: [.drawsAfterEndLocation])
    context.restoreGState()
    
    //Now lets do a 2nd circle
        //Add the same ellipse to the maskPath so it can't be drawn over anymore
        context.addEllipse(in: circle1 ) //This adds circle #1 to the mask
        context.addRect(rect)
        context.clip(using: CGPathFillRule.evenOdd)
        
        context.setFillColor(UIColor.blue.cgColor)
        context.addEllipse(in: circle2 )
        context.drawPath(using: .fillStroke) // or .fillStroke if need filling
    
//    //And finally a 3rd circle
        context.addEllipse(in: circle2) //This adds circle #2 to the mask
        context.addRect(rect)
        context.clip(using: CGPathFillRule.evenOdd)
        
        context.setFillColor(UIColor.red.cgColor)
        context.addEllipse(in: circle3 )
        context.drawPath(using: .fillStroke) // or .fillStroke if need filling

    
    let myImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return myImage!
}

func drawRings(image:UIImage) -> UIImage {
    
    UIGraphicsBeginImageContext(image.size)
    
    image.draw(at: CGPoint.zero) //Copy the sectional onto the new image
    let context = UIGraphicsGetCurrentContext()!
    let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: image.size)
    let colors = RingColors()
    let colorSpace = CGColorSpace(name: CGColorSpace.sRGB)
    //settings for gradient is not used
    context.setLineWidth(2.0)
    context.setStrokeColor(UIColor.red.cgColor)
    context.setLineWidth(5.0)
    
    
    for ringIndex in 0...4{
        for item in landables {
            let point = inches2xy(left: item.tiffX, top: item.tiffY, size: image.size)
            let ring = getRing(height: 5000, landable: item, ringSegment: ringIndex, rings: colors)
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
                                               
        }
    }
    let myImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return myImage!
}

