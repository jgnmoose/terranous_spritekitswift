//
//  GameTextures.swift
//  Terranous
//
//  Created by Jeremy Novak on 7/5/15.
//  Copyright (c) 2015 Jeremy Novak. All rights reserved.
//

import SpriteKit

// MARK: - Sprite Names
class SpriteName {
    // Player
    class var Player:String         { return "Player" }
    class var PlayerLives:String    { return "PlayerLives" }
    // Stars
    class var Star:String           { return "Star" }
    class var StarsCollected:String { return "StarsCollected" }
    // Meteors
    class var Meteor0:String        { return "Meteor0" }
    class var Meteor1:String        { return "Meteor1" }
    class var Meteor2:String        { return "Meteor2" }
    class var Meteor3:String        { return "Meteor3" }
    class var Meteor4:String        { return "Meteor4" }
    // Interface
    class var Title:String          { return "Terranous" }
    class var GameOver:String       { return "GameOver" }
    class var ScoreBoard:String     { return "YourScore" }
    class var Score:String          { return "Score" }
    class var Best:String           { return "Best" }
    class var StarsCount:String     { return "StarsCount" }
    class var VolumeHigh:String     { return "VolumeHigh" }
    class var VolumeLow:String      { return "VolumeLow" }
    // Buttons
    class var ButtonStart:String    { return "StartButton" }
    class var ButtonTap:String      { return "TapButton" }
    class var ButtonRetry:String    { return "Retry" }
    class var ButtonLeaders:String  { return "Leaders" }
    class var ButtonPause:String    { return "PauseButton" }
    class var ButtonResume:String   { return "ResumeButton" }
    class var ButtonSettings:String { return "SettingsButton" }
    class var ButtonMusicOn:String  { return "MusicOn" }
    class var ButtonMusicOff:String { return "MusicOff" }
}

let GameTexturesSharedInstance = GameTextures()

class GameTextures {
    
    class var sharedInstance:GameTextures {
        return GameTexturesSharedInstance
    }
    
    // MARK: - Private class properties
    private var textureAtlas = SKTextureAtlas()
    
    // MARK: - Public class properties
    // Shaders
    internal let shaderPixelate = SKShader(fileNamed: "Pixelate")
    internal let shaderColorize = SKShader(fileNamed: "Colorize")
    // CGPathRefs
    internal var playerCGPath:CGMutablePathRef!
    internal var starCGPath:CGMutablePathRef!
    internal var meteorCGPath0:CGMutablePathRef!
    internal var meteorCGPath1:CGMutablePathRef!
    internal var meteorCGPath2:CGMutablePathRef!
    internal var meteorCGPath3:CGMutablePathRef!
    internal var meteorCGPath4:CGMutablePathRef!
    // Texture Arrays
    internal var explosionTextures = [SKTexture]()
    
    
    // MARK: - Init
    init() {
        self.textureAtlas = SKTextureAtlas(named: "Sprites")
        
        self.shaderPixelate.uniforms = [SKUniform(name: "u_amount", float: 100.0)]
        
        self.setupTextureArrays()
        
        self.setupPlayerCGPathRef()
        self.setupStarCGPathRef()
        self.setupMeteorCGPathRef0()
        self.setupMeteorCGPathRef1()
        self.setupMeteorCGPathRef2()
        self.setupMeteorCGPathRef3()
        self.setupMeteorCGPathRef4()
    }
    
    // MARK: - Sprite Creation
    func spriteWithName(name: String) -> SKSpriteNode {
        return SKSpriteNode(texture: self.textureAtlas.textureNamed(name))
    }
    
    // MARK: - Texture Creation
    func textureWithName(name: String) -> SKTexture {
        return SKTexture(imageNamed: name)
    }
    
    // MARK: - Animation Texture Arrays
    private func setupTextureArrays() {
        for var i = 0; i < 9; i++ {
            self.explosionTextures.append(SKTexture(imageNamed: NSString(format: "Explosion%d", i) as String))
        }
    }
    
    // MARK: - Player CGPathRef
    private func setupPlayerCGPathRef() {
        if kDeviceTablet {
            let sprite = self.spriteWithName(SpriteName.Player)
            
            var offsetX = CGFloat(sprite.frame.size.width * sprite.anchorPoint.x)
            var offsetY = CGFloat(sprite.frame.size.height * sprite.anchorPoint.y)
            
            var path = CGPathCreateMutable()
            
            CGPathMoveToPoint(path, nil, 60 - offsetX, 22 - offsetY)
            CGPathAddLineToPoint(path, nil, 41 - offsetX, 30 - offsetY)
            CGPathAddLineToPoint(path, nil, 40 - offsetX, 32 - offsetY)
            CGPathAddLineToPoint(path, nil, 38 - offsetX, 33 - offsetY)
            CGPathAddLineToPoint(path, nil, 34 - offsetX, 43 - offsetY)
            CGPathAddLineToPoint(path, nil, 30 - offsetX, 44 - offsetY)
            CGPathAddLineToPoint(path, nil, 26 - offsetX, 33 - offsetY)
            CGPathAddLineToPoint(path, nil, 24 - offsetX, 32 - offsetY)
            CGPathAddLineToPoint(path, nil, 23 - offsetX, 31 - offsetY)
            CGPathAddLineToPoint(path, nil, 15 - offsetX, 27 - offsetY)
            CGPathAddLineToPoint(path, nil, 14 - offsetX, 25 - offsetY)
            CGPathAddLineToPoint(path, nil, 4 - offsetX, 22 - offsetY)
            CGPathAddLineToPoint(path, nil, 0 - offsetX, 18 - offsetY)
            CGPathAddLineToPoint(path, nil, 9 - offsetX, 3 - offsetY)
            CGPathAddLineToPoint(path, nil, 13 - offsetX, 3 - offsetY)
            CGPathAddLineToPoint(path, nil, 23 - offsetX, 4 - offsetY)
            CGPathAddLineToPoint(path, nil, 26 - offsetX, 0 - offsetY)
            CGPathAddLineToPoint(path, nil, 39 - offsetX, 0 - offsetY)
            CGPathAddLineToPoint(path, nil, 41 - offsetX, 4 - offsetY)
            CGPathAddLineToPoint(path, nil, 44 - offsetX, 4 - offsetY)
            CGPathAddLineToPoint(path, nil, 52 - offsetX, 2 - offsetY)
            CGPathAddLineToPoint(path, nil, 55 - offsetX, 4 - offsetY)
            CGPathAddLineToPoint(path, nil, 61 - offsetX, 13 - offsetY)
            CGPathAddLineToPoint(path, nil, 64 - offsetX, 19 - offsetY)
            
            CGPathCloseSubpath(path)
            
            self.playerCGPath = path
        } else {
            let sprite = self.spriteWithName(SpriteName.Player)
            
            var offsetX = CGFloat(sprite.frame.size.width * sprite.anchorPoint.x)
            var offsetY = CGFloat(sprite.frame.size.height * sprite.anchorPoint.y)
            
            var path = CGPathCreateMutable()
            
            CGPathMoveToPoint(path, nil, 31 - offsetX, 11 - offsetY)
            CGPathAddLineToPoint(path, nil, 20 - offsetX, 16 - offsetY)
            CGPathAddLineToPoint(path, nil, 19 - offsetX, 18 - offsetY)
            CGPathAddLineToPoint(path, nil, 17 - offsetX, 22 - offsetY)
            CGPathAddLineToPoint(path, nil, 15 - offsetX, 22 - offsetY)
            CGPathAddLineToPoint(path, nil, 11 - offsetX, 16 - offsetY)
            CGPathAddLineToPoint(path, nil, 2 - offsetX, 11 - offsetY)
            CGPathAddLineToPoint(path, nil, 0 - offsetX, 10 - offsetY)
            CGPathAddLineToPoint(path, nil, 5 - offsetX, 2 - offsetY)
            CGPathAddLineToPoint(path, nil, 10 - offsetX, 3 - offsetY)
            CGPathAddLineToPoint(path, nil, 12 - offsetX, 2 - offsetY)
            CGPathAddLineToPoint(path, nil, 13 - offsetX, 1 - offsetY)
            CGPathAddLineToPoint(path, nil, 20 - offsetX, 1 - offsetY)
            CGPathAddLineToPoint(path, nil, 21 - offsetX, 2 - offsetY)
            CGPathAddLineToPoint(path, nil, 22 - offsetX, 3 - offsetY)
            CGPathAddLineToPoint(path, nil, 26 - offsetX, 2 - offsetY)
            CGPathAddLineToPoint(path, nil, 28 - offsetX, 2 - offsetY)
            CGPathAddLineToPoint(path, nil, 32 - offsetX, 10 - offsetY)
            
            CGPathCloseSubpath(path)
            
            self.playerCGPath = path
        }
    }
    
    // MARK: - Star CGPathRef
    private func setupStarCGPathRef() {
        if kDeviceTablet {
            let sprite = self.spriteWithName(SpriteName.Star)
            
            var offsetX = CGFloat(sprite.frame.size.width * sprite.anchorPoint.x)
            var offsetY = CGFloat(sprite.frame.size.height * sprite.anchorPoint.y)
            
            var path = CGPathCreateMutable()
            
            CGPathMoveToPoint(path, nil, 46 - offsetX, 23 - offsetY)
            CGPathAddLineToPoint(path, nil, 48 - offsetX, 28 - offsetY)
            CGPathAddLineToPoint(path, nil, 47 - offsetX, 30 - offsetY)
            CGPathAddLineToPoint(path, nil, 34 - offsetX, 35 - offsetY)
            CGPathAddLineToPoint(path, nil, 28 - offsetX, 43 - offsetY)
            CGPathAddLineToPoint(path, nil, 24 - offsetX, 46 - offsetY)
            CGPathAddLineToPoint(path, nil, 20 - offsetX, 43 - offsetY)
            CGPathAddLineToPoint(path, nil, 14 - offsetX, 36 - offsetY)
            CGPathAddLineToPoint(path, nil, 1 - offsetX, 30 - offsetY)
            CGPathAddLineToPoint(path, nil, 0 - offsetX, 28 - offsetY)
            CGPathAddLineToPoint(path, nil, 1 - offsetX, 26 - offsetY)
            CGPathAddLineToPoint(path, nil, 7 - offsetX, 16 - offsetY)
            CGPathAddLineToPoint(path, nil, 8 - offsetX, 3 - offsetY)
            CGPathAddLineToPoint(path, nil, 9 - offsetX, 1 - offsetY)
            CGPathAddLineToPoint(path, nil, 15 - offsetX, 1 - offsetY)
            CGPathAddLineToPoint(path, nil, 24 - offsetX, 4 - offsetY)
            CGPathAddLineToPoint(path, nil, 34 - offsetX, 1 - offsetY)
            CGPathAddLineToPoint(path, nil, 39 - offsetX, 1 - offsetY)
            CGPathAddLineToPoint(path, nil, 40 - offsetX, 7 - offsetY)
            CGPathAddLineToPoint(path, nil, 40 - offsetX, 15 - offsetY)
            CGPathAddLineToPoint(path, nil, 44 - offsetX, 21 - offsetY)
            
            CGPathCloseSubpath(path)
            
            self.starCGPath = path
        } else {
            let sprite = self.spriteWithName(SpriteName.Star)
            
            var offsetX = CGFloat(sprite.frame.size.width * sprite.anchorPoint.x)
            var offsetY = CGFloat(sprite.frame.size.height * sprite.anchorPoint.y)
            
            var path = CGPathCreateMutable()
            
            CGPathMoveToPoint(path, nil, 23 - offsetX, 12 - offsetY)
            CGPathAddLineToPoint(path, nil, 24 - offsetX, 13 - offsetY)
            CGPathAddLineToPoint(path, nil, 24 - offsetX, 15 - offsetY)
            CGPathAddLineToPoint(path, nil, 18 - offsetX, 17 - offsetY)
            CGPathAddLineToPoint(path, nil, 15 - offsetX, 21 - offsetY)
            CGPathAddLineToPoint(path, nil, 12 - offsetX, 23 - offsetY)
            CGPathAddLineToPoint(path, nil, 11 - offsetX, 23 - offsetY)
            CGPathAddLineToPoint(path, nil, 7 - offsetX, 18 - offsetY)
            CGPathAddLineToPoint(path, nil, 0 - offsetX, 15 - offsetY)
            CGPathAddLineToPoint(path, nil, 1 - offsetX, 13 - offsetY)
            CGPathAddLineToPoint(path, nil, 4 - offsetX, 7 - offsetY)
            CGPathAddLineToPoint(path, nil, 5 - offsetX, 1 - offsetY)
            CGPathAddLineToPoint(path, nil, 9 - offsetX, 1 - offsetY)
            CGPathAddLineToPoint(path, nil, 11 - offsetX, 2 - offsetY)
            CGPathAddLineToPoint(path, nil, 20 - offsetX, 1 - offsetY)
            CGPathAddLineToPoint(path, nil, 20 - offsetX, 7 - offsetY)
            CGPathAddLineToPoint(path, nil, 22 - offsetX, 11 - offsetY)
            
            CGPathCloseSubpath(path)
            
            self.starCGPath = path
        }
    }
    
    // MARK: - Meteor 0
    private func setupMeteorCGPathRef0() {
        if kDeviceTablet {
            let sprite = SKSpriteNode(imageNamed: SpriteName.Meteor0)
            
            var offsetX = CGFloat(sprite.frame.size.width * sprite.anchorPoint.x)
            var offsetY = CGFloat(sprite.frame.size.height * sprite.anchorPoint.y)
            
            var path = CGPathCreateMutable()
            
            CGPathMoveToPoint(path, nil, 89 - offsetX, 39 - offsetY)
            CGPathAddLineToPoint(path, nil, 95 - offsetX, 59 - offsetY)
            CGPathAddLineToPoint(path, nil, 95 - offsetX, 64 - offsetY)
            CGPathAddLineToPoint(path, nil, 59 - offsetX, 76 - offsetY)
            CGPathAddLineToPoint(path, nil, 52 - offsetX, 78 - offsetY)
            CGPathAddLineToPoint(path, nil, 25 - offsetX, 74 - offsetY)
            CGPathAddLineToPoint(path, nil, 16 - offsetX, 71 - offsetY)
            CGPathAddLineToPoint(path, nil, 1 - offsetX, 44 - offsetY)
            CGPathAddLineToPoint(path, nil, 4 - offsetX, 21 - offsetY)
            CGPathAddLineToPoint(path, nil, 6 - offsetX, 17 - offsetY)
            CGPathAddLineToPoint(path, nil, 21 - offsetX, 5 - offsetY)
            CGPathAddLineToPoint(path, nil, 28 - offsetX, 1 - offsetY)
            CGPathAddLineToPoint(path, nil, 39 - offsetX, 11 - offsetY)
            CGPathAddLineToPoint(path, nil, 43 - offsetX, 13 - offsetY)
            CGPathAddLineToPoint(path, nil, 84 - offsetX, 24 - offsetY)
            CGPathAddLineToPoint(path, nil, 86 - offsetX, 28 - offsetY)
            CGPathAddLineToPoint(path, nil, 88 - offsetX, 35 - offsetY)
            
            CGPathCloseSubpath(path)
            
            self.meteorCGPath0 = path
        } else {
            let sprite = SKSpriteNode(imageNamed: SpriteName.Meteor0)
            
            var offsetX = CGFloat(sprite.frame.size.width * sprite.anchorPoint.x)
            var offsetY = CGFloat(sprite.frame.size.height * sprite.anchorPoint.y)
            
            var path = CGPathCreateMutable()
            
            CGPathMoveToPoint(path, nil, 44 - offsetX, 20 - offsetY)
            CGPathAddLineToPoint(path, nil, 47 - offsetX, 29 - offsetY)
            CGPathAddLineToPoint(path, nil, 47 - offsetX, 32 - offsetY)
            CGPathAddLineToPoint(path, nil, 28 - offsetX, 39 - offsetY)
            CGPathAddLineToPoint(path, nil, 21 - offsetX, 38 - offsetY)
            CGPathAddLineToPoint(path, nil, 8 - offsetX, 36 - offsetY)
            CGPathAddLineToPoint(path, nil, 0 - offsetX, 22 - offsetY)
            CGPathAddLineToPoint(path, nil, 2 - offsetX, 13 - offsetY)
            CGPathAddLineToPoint(path, nil, 3 - offsetX, 8 - offsetY)
            CGPathAddLineToPoint(path, nil, 14 - offsetX, 1 - offsetY)
            CGPathAddLineToPoint(path, nil, 20 - offsetX, 6 - offsetY)
            CGPathAddLineToPoint(path, nil, 23 - offsetX, 7 - offsetY)
            CGPathAddLineToPoint(path, nil, 42 - offsetX, 12 - offsetY)
            CGPathAddLineToPoint(path, nil, 44 - offsetX, 18 - offsetY)
            
            CGPathCloseSubpath(path)
            
            CGPathCloseSubpath(path)
            
            self.meteorCGPath0 = path
        }
    }
    
    // MARK: - Meteor 1
    private func setupMeteorCGPathRef1() {
        if kDeviceTablet {
            let sprite = SKSpriteNode(imageNamed: SpriteName.Meteor1)
            
            var offsetX = CGFloat(sprite.frame.size.width * sprite.anchorPoint.x)
            var offsetY = CGFloat(sprite.frame.size.height * sprite.anchorPoint.y)
            
            var path = CGPathCreateMutable()
            
            CGPathMoveToPoint(path, nil, 79 - offsetX, 33 - offsetY)
            CGPathAddLineToPoint(path, nil, 78 - offsetX, 37 - offsetY)
            CGPathAddLineToPoint(path, nil, 61 - offsetX, 63 - offsetY)
            CGPathAddLineToPoint(path, nil, 58 - offsetX, 66 - offsetY)
            CGPathAddLineToPoint(path, nil, 14 - offsetX, 66 - offsetY)
            CGPathAddLineToPoint(path, nil, 4 - offsetX, 37 - offsetY)
            CGPathAddLineToPoint(path, nil, 1 - offsetX, 25 - offsetY)
            CGPathAddLineToPoint(path, nil, 20 - offsetX, 3 - offsetY)
            CGPathAddLineToPoint(path, nil, 23 - offsetX, 1 - offsetY)
            CGPathAddLineToPoint(path, nil, 47 - offsetX, 10 - offsetY)
            CGPathAddLineToPoint(path, nil, 66 - offsetX, 8 - offsetY)
            CGPathAddLineToPoint(path, nil, 69 - offsetX, 10 - offsetY)
            CGPathAddLineToPoint(path, nil, 77 - offsetX, 29 - offsetY)
            
            CGPathCloseSubpath(path)
            
            self.meteorCGPath1 = path
        } else {
            let sprite = SKSpriteNode(imageNamed: SpriteName.Meteor1)
            
            var offsetX = CGFloat(sprite.frame.size.width * sprite.anchorPoint.x)
            var offsetY = CGFloat(sprite.frame.size.height * sprite.anchorPoint.y)
            
            var path = CGPathCreateMutable()
            
            CGPathMoveToPoint(path, nil, 40 - offsetX, 17 - offsetY)
            CGPathAddLineToPoint(path, nil, 39 - offsetX, 19 - offsetY)
            CGPathAddLineToPoint(path, nil, 29 - offsetX, 33 - offsetY)
            CGPathAddLineToPoint(path, nil, 7 - offsetX, 33 - offsetY)
            CGPathAddLineToPoint(path, nil, 0 - offsetX, 13 - offsetY)
            CGPathAddLineToPoint(path, nil, 12 - offsetX, 1 - offsetY)
            CGPathAddLineToPoint(path, nil, 24 - offsetX, 5 - offsetY)
            CGPathAddLineToPoint(path, nil, 33 - offsetX, 4 - offsetY)
            CGPathAddLineToPoint(path, nil, 34 - offsetX, 5 - offsetY)
            CGPathAddLineToPoint(path, nil, 39 - offsetX, 15 - offsetY)
            
            CGPathCloseSubpath(path)
            
            self.meteorCGPath1 = path
        }
    }
    
    // MARK: - Meteor 2
    private func setupMeteorCGPathRef2() {
        if kDeviceTablet {
            let sprite = SKSpriteNode(imageNamed: SpriteName.Meteor2)
            
            var offsetX = CGFloat(sprite.frame.size.width * sprite.anchorPoint.x)
            var offsetY = CGFloat(sprite.frame.size.height * sprite.anchorPoint.y)
            
            var path = CGPathCreateMutable()
            
            CGPathMoveToPoint(path, nil, 64 - offsetX, 30 - offsetY)
            CGPathAddLineToPoint(path, nil, 53 - offsetX, 50 - offsetY)
            CGPathAddLineToPoint(path, nil, 26 - offsetX, 59 - offsetY)
            CGPathAddLineToPoint(path, nil, 23 - offsetX, 58 - offsetY)
            CGPathAddLineToPoint(path, nil, 3 - offsetX, 46 - offsetY)
            CGPathAddLineToPoint(path, nil, 0 - offsetX, 43 - offsetY)
            CGPathAddLineToPoint(path, nil, 2 - offsetX, 20 - offsetY)
            CGPathAddLineToPoint(path, nil, 5 - offsetX, 15 - offsetY)
            CGPathAddLineToPoint(path, nil, 13 - offsetX, 6 - offsetY)
            CGPathAddLineToPoint(path, nil, 48 - offsetX, 1 - offsetY)
            CGPathAddLineToPoint(path, nil, 62 - offsetX, 27 - offsetY)
            
            CGPathCloseSubpath(path)
            
            self.meteorCGPath2 = path
        } else {
            let sprite = SKSpriteNode(imageNamed: SpriteName.Meteor2)
            
            var offsetX = CGFloat(sprite.frame.size.width * sprite.anchorPoint.x)
            var offsetY = CGFloat(sprite.frame.size.height * sprite.anchorPoint.y)
            
            var path = CGPathCreateMutable()
            
            CGPathMoveToPoint(path, nil, 32 - offsetX, 15 - offsetY)
            CGPathAddLineToPoint(path, nil, 27 - offsetX, 25 - offsetY)
            CGPathAddLineToPoint(path, nil, 13 - offsetX, 30 - offsetY)
            CGPathAddLineToPoint(path, nil, 12 - offsetX, 30 - offsetY)
            CGPathAddLineToPoint(path, nil, 5 - offsetX, 26 - offsetY)
            CGPathAddLineToPoint(path, nil, 1 - offsetX, 23 - offsetY)
            CGPathAddLineToPoint(path, nil, 0 - offsetX, 21 - offsetY)
            CGPathAddLineToPoint(path, nil, 1 - offsetX, 10 - offsetY)
            CGPathAddLineToPoint(path, nil, 4 - offsetX, 5 - offsetY)
            CGPathAddLineToPoint(path, nil, 8 - offsetX, 2 - offsetY)
            CGPathAddLineToPoint(path, nil, 24 - offsetX, 0 - offsetY)
            CGPathAddLineToPoint(path, nil, 31 - offsetX, 13 - offsetY)
            
            CGPathCloseSubpath(path)
            
            self.meteorCGPath2 = path
        }
    }
    
    // MARK: - Meteor 3
    private func setupMeteorCGPathRef3() {
        if kDeviceTablet {
            let sprite = SKSpriteNode(imageNamed: SpriteName.Meteor3)
            
            var offsetX = CGFloat(sprite.frame.size.width * sprite.anchorPoint.x)
            var offsetY = CGFloat(sprite.frame.size.height * sprite.anchorPoint.y)
            
            var path = CGPathCreateMutable()
            
            CGPathMoveToPoint(path, nil, 46 - offsetX, 24 - offsetY)
            CGPathAddLineToPoint(path, nil, 48 - offsetX, 28 - offsetY)
            CGPathAddLineToPoint(path, nil, 48 - offsetX, 31 - offsetY)
            CGPathAddLineToPoint(path, nil, 34 - offsetX, 46 - offsetY)
            CGPathAddLineToPoint(path, nil, 31 - offsetX, 47 - offsetY)
            CGPathAddLineToPoint(path, nil, 7 - offsetX, 41 - offsetY)
            CGPathAddLineToPoint(path, nil, 5 - offsetX, 36 - offsetY)
            CGPathAddLineToPoint(path, nil, 0 - offsetX, 19 - offsetY)
            CGPathAddLineToPoint(path, nil, 15 - offsetX, 1 - offsetY)
            CGPathAddLineToPoint(path, nil, 38 - offsetX, 3 - offsetY)
            CGPathAddLineToPoint(path, nil, 40 - offsetX, 5 - offsetY)
            CGPathAddLineToPoint(path, nil, 45 - offsetX, 22 - offsetY)
            
            CGPathCloseSubpath(path)
            
            self.meteorCGPath3 = path
        } else {
            let sprite = SKSpriteNode(imageNamed: SpriteName.Meteor3)
            
            var offsetX = CGFloat(sprite.frame.size.width * sprite.anchorPoint.x)
            var offsetY = CGFloat(sprite.frame.size.height * sprite.anchorPoint.y)
            
            var path = CGPathCreateMutable()
            
            CGPathMoveToPoint(path, nil, 23 - offsetX, 12 - offsetY)
            CGPathAddLineToPoint(path, nil, 23 - offsetX, 16 - offsetY)
            CGPathAddLineToPoint(path, nil, 17 - offsetX, 23 - offsetY)
            CGPathAddLineToPoint(path, nil, 15 - offsetX, 24 - offsetY)
            CGPathAddLineToPoint(path, nil, 3 - offsetX, 21 - offsetY)
            CGPathAddLineToPoint(path, nil, 0 - offsetX, 9 - offsetY)
            CGPathAddLineToPoint(path, nil, 7 - offsetX, 0 - offsetY)
            CGPathAddLineToPoint(path, nil, 10 - offsetX, 0 - offsetY)
            CGPathAddLineToPoint(path, nil, 19 - offsetX, 1 - offsetY)
            CGPathAddLineToPoint(path, nil, 23 - offsetX, 11 - offsetY)
            
            CGPathCloseSubpath(path)
            
            self.meteorCGPath3 = path
        }
    }
    
    // MARK: - Meteor 4
    private func setupMeteorCGPathRef4() {
        if kDeviceTablet {
            let sprite = SKSpriteNode(imageNamed: SpriteName.Meteor4)
            
            var offsetX = CGFloat(sprite.frame.size.width * sprite.anchorPoint.x)
            var offsetY = CGFloat(sprite.frame.size.height * sprite.anchorPoint.y)
            
            var path = CGPathCreateMutable()
            
            CGPathMoveToPoint(path, nil, 31 - offsetX, 16 - offsetY)
            CGPathAddLineToPoint(path, nil, 30 - offsetX, 25 - offsetY)
            CGPathAddLineToPoint(path, nil, 28 - offsetX, 31 - offsetY)
            CGPathAddLineToPoint(path, nil, 13 - offsetX, 32 - offsetY)
            CGPathAddLineToPoint(path, nil, 8 - offsetX, 31 - offsetY)
            CGPathAddLineToPoint(path, nil, 1 - offsetX, 22 - offsetY)
            CGPathAddLineToPoint(path, nil, 0 - offsetX, 19 - offsetY)
            CGPathAddLineToPoint(path, nil, 4 - offsetX, 6 - offsetY)
            CGPathAddLineToPoint(path, nil, 6 - offsetX, 4 - offsetY)
            CGPathAddLineToPoint(path, nil, 15 - offsetX, 0 - offsetY)
            CGPathAddLineToPoint(path, nil, 18 - offsetX, 1 - offsetY)
            CGPathAddLineToPoint(path, nil, 31 - offsetX, 9 - offsetY)
            CGPathAddLineToPoint(path, nil, 32 - offsetX, 14 - offsetY)
            
            CGPathCloseSubpath(path)
            
            self.meteorCGPath4 = path
        } else {
            let sprite = SKSpriteNode(imageNamed: SpriteName.Meteor4)
            
            var offsetX = CGFloat(sprite.frame.size.width * sprite.anchorPoint.x)
            var offsetY = CGFloat(sprite.frame.size.height * sprite.anchorPoint.y)
            
            var path = CGPathCreateMutable()
            
            CGPathMoveToPoint(path, nil, 16 - offsetX, 8 - offsetY)
            CGPathAddLineToPoint(path, nil, 14 - offsetX, 15 - offsetY)
            CGPathAddLineToPoint(path, nil, 5 - offsetX, 16 - offsetY)
            CGPathAddLineToPoint(path, nil, 0 - offsetX, 11 - offsetY)
            CGPathAddLineToPoint(path, nil, 0 - offsetX, 8 - offsetY)
            CGPathAddLineToPoint(path, nil, 2 - offsetX, 3 - offsetY)
            CGPathAddLineToPoint(path, nil, 4 - offsetX, 1 - offsetY)
            CGPathAddLineToPoint(path, nil, 6 - offsetX, 0 - offsetY)
            CGPathAddLineToPoint(path, nil, 9 - offsetX, 0 - offsetY)
            CGPathAddLineToPoint(path, nil, 15 - offsetX, 4 - offsetY)
            CGPathAddLineToPoint(path, nil, 16 - offsetX, 5 - offsetY)
            CGPathAddLineToPoint(path, nil, 16 - offsetX, 7 - offsetY)
            
            CGPathCloseSubpath(path)
            
            self.meteorCGPath4 = path
        }
    }
}
