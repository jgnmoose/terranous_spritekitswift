//
//  MeteorController.swift
//  Terranous
//
//  Created by Jeremy Novak on 7/5/15.
//  Copyright (c) 2015 Jeremy Novak. All rights reserved.
//

import SpriteKit

class MeteorController: SKNode {
    // MARK: - Private class properties
    private var sendingMeteors = false
    private var movingMeteors = false
    private var frameCount = 0.0
    
    private let meteor0 = Meteor(type: Meteor.MeteorType.Zero)
    private let meteor1 = Meteor(type: Meteor.MeteorType.One)
    private let meteor2 = Meteor(type: Meteor.MeteorType.Two)
    private let meteor3 = Meteor(type: Meteor.MeteorType.Three)
    private let meteor4 = Meteor(type: Meteor.MeteorType.Four)
    
    private var meteorArray = [SKSpriteNode]()
    
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        
        self.setupMeteorController()
    }
    
    // MARK: - Setup Functions
    private func setupMeteorController() {
        self.meteorArray = [self.meteor0, self.meteor1, self.meteor2, self.meteor3, self.meteor4]
    }
    
    // MARK: - Action Functions
    func sendMeteors() {
        if self.sendingMeteors {
            
            var randomMeteorCount = 0
            
            if kDeviceTablet {
                randomMeteorCount = RandomIntegerBetween(8, 12)
            } else {
                randomMeteorCount = RandomIntegerBetween(10, 16)
            }
            
            for var i = 0; i <= randomMeteorCount; i++ {
                let randomMeteorIndex = RandomIntegerBetween(0, 4)
                
                var offsetX:CGFloat = randomMeteorIndex % 2 == 0 ? -72 : 72
                let startX = RandomFloatRange(0, kViewSize.width) + offsetX
                
                var offsetY:CGFloat = randomMeteorIndex % 2 == 0 ? 72 : -72
                let startY = kViewSize.height * 1.25 + offsetY
                
                
                let meteor = self.meteorArray[randomMeteorIndex].copy() as! Meteor
                meteor.drift = RandomFloatRange(-0.5, 0.5)
                
                meteor.position = CGPoint(x: startX, y: startY)
                
                self.addChild(meteor)
            }
            
            NSNotificationCenter.defaultCenter().postNotificationName("rumbleScreen", object: nil)
        }
    }
    
    func startSendingMeteors() {
        self.sendingMeteors = true
        self.movingMeteors = true
    }
    
    func stopSendingMeteors() {
        self.sendingMeteors = false
        self.movingMeteors = false
        
        self.frameCount = 0.0
    }
    
    // MARK: - Update
    func update(delta: NSTimeInterval) {
        if self.sendingMeteors {
            self.frameCount += delta
            
            if self.frameCount >= 3.0 {
                self.sendMeteors()
                
                self.frameCount = 0.0
            }
        }
        
        if self.movingMeteors {
            for node in self.children {
                if let meteor = node as? Meteor {
                    meteor.update(delta)
                }
            }
        }
    }
    
    // MARK: - Action Functions
    func rewindMeteors() {
        self.sendingMeteors = false
        
        for node in self.children {
            if let meteor = node as? Meteor {
                self.sendingMeteors = false
                meteor.runAction(SKAction.moveToY(meteor.position.y + meteor.size.height * 2, duration: 1.0), completion: {
                    self.sendingMeteors = true
                })
            }
        }
    }
    
    // MARK: - Action Functions
    func gameOver() {
        for node in self.children {
            if let meteor = node as? Meteor {
                meteor.gameOver()
            }
        }
    }
}

