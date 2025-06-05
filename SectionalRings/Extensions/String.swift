//
//  String.swift
//  SectionalRings
//
//  Created by Chuck Deerinck on 6/2/25.
//

import Foundation
import UIKit

extension String {
   func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
