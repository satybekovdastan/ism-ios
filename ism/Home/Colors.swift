//
//  Colors.swift
//  OobaMarket-kg
//
//  Created by Artem Kirnos on 8/25/17.
//  Copyright © 2017 SunriseStudio. All rights reserved.
//

import UIKit

class Colors: NSObject {
    
    // 248 248 248 - белый серым оттенком
    // 251 251 251 - почти белый
    // 220 220 220 - ligth gray
    // 17 235 230 - бирюзовый
    // 178 48 83 - бирюзовый2 #6ED3CF
    // 224 253 252 - светло бирюзовый
    
    static let whiteGrayBackground = Colors.colorWithRGB(r: 245, g: 245, b: 245)
    static let whiteBackground = Colors.colorWithRGB(r: 251, g: 251, b: 251)
    //    static let turquoise = Colors.colorWithHEX(hex: 0x6ED3CF)
    static let turquoise = Colors.colorWithRGB(r: 110, g: 211, b: 207)
    static let lightTurquoise = Colors.colorWithRGB(r: 224, g: 253, b: 252)
    static let lightGray = Colors.colorWithRGB(r: 220, g: 220, b: 220)
    static let googlePlusButton = Colors.colorWithRGB(r: 220, g: 75, b: 57)
    static let facebookButton = Colors.colorWithRGB(r: 59, g: 89, b: 152)
    static let secondCompanyColor = Colors.colorWithRGB(r: 91, g: 172, b: 202)
    static let waitYellowColor = Colors.colorWithRGB(r: 238, g: 160, b: 77)
    static let successGreenColor = Colors.colorWithRGB(r: 0, g: 142, b: 42)
    
    //RGB GENERATOR
    static func colorWithRGB(r:Int, g:Int, b:Int) -> UIColor {
        return UIColor(red: CGFloat.init(r)/255, green: CGFloat.init(g)/255, blue: CGFloat.init(b)/255, alpha: 1)
    }
    
    //HEX GENERATOR
    static func colorWithHEX(hex:Int) -> UIColor {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        return UIColor(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
}
