//
//  UIColor+BinAdd.swift
//  AIAFramework
//
//  Created by LeGuo on 4/2/18.
//  Copyright © 2018 LeGuo. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    
    /**
     Generate color with hex of 32bit int
     - parameter hex: Hex integer value of color
     - returns: The color which default alpha is 1.0.
     */
    convenience init(withHex hex:UInt32) {
        self.init(withHex: hex, andAlpha: 1.0)
    }
    
    /**
     Generate color with hex string and alpha value
     - parameter hex: Hex value of color
     - parameter alpha: Alpha value of color
     - returns: The color.
     */
    convenience init(withHex hex:UInt32, andAlpha alpha:CGFloat) {
        
       self.init(red:CGFloat.init(((hex >> 16) & 0xFF))/255.0,
                            green:CGFloat.init(((hex >> 8) & 0xFF))/255.0,
                            blue:CGFloat.init((hex & 0xFF))/255.0,
                            alpha: alpha)
    }
    
    /**
     Generate color with hex String
     - parameter hex: Hex value of color
     - returns: The color.
     */
    convenience init(withHexString hex:String){
        
        var alpha:CGFloat = 0
        var red:CGFloat = 0
        var blue:CGFloat = 0
        var green:CGFloat = 0
        
        let colorString = hex.replacingOccurrences(of: "#", with: "")
        switch colorString.count {
        case 3:
            alpha = 1.0;
            red = colorComponent(ofString: colorString, from: 0, atLength: 1)
            green = colorComponent(ofString: colorString, from: 1, atLength: 1)
            blue = colorComponent(ofString: colorString, from: 2, atLength: 1)
        case 4:
            alpha = colorComponent(ofString: colorString, from: 0, atLength: 1)
            red = colorComponent(ofString: colorString, from: 1, atLength: 1)
            green = colorComponent(ofString: colorString, from: 2, atLength: 1)
            blue = colorComponent(ofString: colorString, from: 3, atLength: 1)
        case 6:
            alpha = colorComponent(ofString: colorString, from: 0, atLength: 2)
            red = colorComponent(ofString: colorString, from: 2, atLength: 2)
            green = colorComponent(ofString: colorString, from: 4, atLength: 2)
        case 8:
            alpha = colorComponent(ofString: colorString, from: 0, atLength: 2)
            red = colorComponent(ofString: colorString, from: 2, atLength: 2)
            green = colorComponent(ofString: colorString, from: 4, atLength: 2)
            blue = colorComponent(ofString: colorString, from: 6, atLength: 2)
        default:
            break
        }
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    convenience init(withWholeRed red:CGFloat,_ green:CGFloat, _ blue:CGFloat) {
        self.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
    }
}

fileprivate func colorComponent(ofString string: String, from start:Int, atLength length:Int) -> CGFloat {
    
    let startIndex = string.index(string.startIndex, offsetBy: start, limitedBy:string.endIndex)
    let endIndex = string.index(string.startIndex, offsetBy:start+length, limitedBy:string.endIndex)
    
    var substring = "00"
    if startIndex != nil && endIndex != nil {
        substring = String(string[startIndex! ..< endIndex!])
    }
    
    let fullHex = substring.count == 2 ? substring:substring+substring
    
    var hexComponent:UInt32 = 0
    Scanner.init(string: fullHex).scanHexInt32(&hexComponent)
    
    return CGFloat.init(hexComponent)/255.0;
}

