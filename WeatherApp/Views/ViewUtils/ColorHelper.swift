//
//  ColorHelper.swift
//  WeatherApp
//
//  Created by Angel Escribano on 23/2/18.
//  Copyright © 2018 -. All rights reserved.
//

import UIKit


class ColorHelper {
    
    class func getGradientColors() -> [CGColor]{
        let gradient = ["#2C03FA", "#403DD5", "#5478B1", "#68B28C", "#7CED68", "#9CEF4E", "#BDF235", "#DEF41C", "#FFF703", "#FFD502", "#FFB301", "#FF9100", "#FF6003", "#FF3006", "#FF0009"]
        var colors:[CGColor] = []
        for color in gradient {
            colors.append(UIColor.init(hexString: color).cgColor)
        }
        return colors
    }
}

extension UIColor {
    convenience init(hexString:String) {
        let hexString:String = hexString.trimmingCharacters(in:CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
}
