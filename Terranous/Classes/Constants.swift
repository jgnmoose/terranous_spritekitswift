//
//  Constants.swift
//  Terranous
//
//  Created by Jeremy Novak on 7/5/15.
//  Copyright (c) 2015 Jeremy Novak. All rights reserved.
//

import Foundation
import SpriteKit

// MARK: - Debug
let kDebug = true

// MARK: - Device size support
let kDeviceTablet = (UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad)

// MARK: - Screen Dimenions
let kScreenCenterHorizontal = UIScreen.mainScreen().bounds.size.width / 2
let kScreenCenterVertical = UIScreen.mainScreen().bounds.size.height / 2
let kScreenCenter = CGPoint(x: kScreenCenterHorizontal, y: kScreenCenterVertical)
let kViewSize = UIScreen.mainScreen().bounds.size

// MARK: - Category Bitmasks
class Contact {
    class var Scene:UInt32      { return 1 << 0 }
    class var Meteor:UInt32     { return 1 << 1 }
    class var Star:UInt32       { return 1 << 2 }
    class var Player:UInt32     { return 1 << 3 }
}

// MARK: - Game Layers
class GameLayer {
    class var Game:CGFloat      { return 0 }
    class var Interface:CGFloat { return 1 }
    class var Settings:CGFloat  { return 2 }
}

// MARK: - Object Names
class ObjectName {
    class var Player:String             { return "Player" }
    class var Star:String               { return "Star" }
    class var StarController:String     { return "StarController" }
    class var Meteor:String             { return "Meteor" }
    class var MeteorController:String   { return "MeteorController" }
}

// MARK: - Colors
class Colors {
    class var Background:Int    { return 0x180d1f }
    class var Flash:Int         { return 0x1c75bc }
}

// MARK: - Convenience Functions
func SKColorFromRGB(rgbValue: Int) -> SKColor {
    return SKColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: 1.0)
}

// MARK: - Animation Functions
func Smooth(a: CGFloat, b: CGFloat, filter: CGFloat) -> CGFloat {
    return (a * (1 - filter)) + b * filter
}

// MARK: - Math Functions
func RandomIntegerBetween(min: Int, max: Int) -> Int {
    return Int(UInt32(min) + arc4random_uniform(UInt32(max - min + 1)))
}


func RandomFloatRange(min: CGFloat, max: CGFloat) -> CGFloat {
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF) * (max - min) + min
}

func RadiansToDegrees(degrees: CGFloat) -> CGFloat {
    return degrees * CGFloat(180.0 / M_PI)
}