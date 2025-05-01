//
//  overlayImage.swift
//  SectionalRings
//
//  Created by Luke Deerinck on 5/1/25.
//

import Foundation

import Foundation
import SwiftUI

func overlayImage(image: UIImage) -> UIImage{
    
    
    UIGraphicsBeginImageContext(image.size)
    
    image.draw(at: CGPoint.zero) //Copy the sectional onto the new image
    
    // Setup the font specific variables
    let textColor = UIColor.black
    let textFont = UIFont(name: "Helvetica Bold", size: 235)!
    let backgroundColor = UIColor.white.withAlphaComponent(1)
    // Setup the font attributes that will be later used to dictate how the text should be drawn
    let textFontAttributes = [
        NSAttributedString.Key.font: textFont,
        NSAttributedString.Key.foregroundColor: textColor,
        NSAttributedString.Key.backgroundColor:backgroundColor,
    ]
    // Create a rect where you want the text
    let rect = CGRectMake(50, 50, image.size.width, image.size.height)

    // Draw the text into an image
    let drawText: NSString = displayInfo(ring: RingColors()) as NSString
    drawText.draw(in: rect, withAttributes: textFontAttributes)
    
    // Create a new image out of the images we have created
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    
    // End the context now that we have the image we need
    UIGraphicsEndImageContext()
    
    return newImage!
}
