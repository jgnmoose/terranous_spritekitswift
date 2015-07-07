//
//  Meteors.swift
//  Terranous
//
//  Created by Jeremy Novak on 7/5/15.
//  Copyright (c) 2015 Jeremy Novak. All rights reserved.
//

import SpriteKit

class Meteor: SKSpriteNode {
    
    // MARK: - Private class properties
    
    // MARK: - Public class properties
    internal enum MeteorType:Int {
        case Zero
        case One
        case Two
        case Three
        case Four
    }
    
    internal var didContact = false
    internal var drift = CGFloat()
    
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init(type: MeteorType) {
        var texture = SKTexture()
        
        switch type {
        case MeteorType.Zero:
            texture = SKTexture(imageNamed: SpriteName.Meteor0)
            break
            
        case MeteorType.One:
            texture = SKTexture(imageNamed: SpriteName.Meteor1)
            break
            
        case MeteorType.Two:
            texture = SKTexture(imageNamed: SpriteName.Meteor2)
            break
            
        case MeteorType.Three:
            texture = SKTexture(imageNamed: SpriteName.Meteor3)
            break
            
        case MeteorType.Four:
            texture = SKTexture(imageNamed: SpriteName.Meteor4)
            break
            
        default:
            texture = SKTexture(imageNamed: SpriteName.Meteor0)
            break
            
        }
        
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        
        self.setupMeteor()
        self.setupMeteorPhysics(type)
    }
    
    // MARK: - Setup Functions
    private func setupMeteor() {
    }
    
    private func setupMeteorPhysics(type: MeteorType) {
        switch type {
        case MeteorType.Zero:
            self.physicsBody = SKPhysicsBody(polygonFromPath: GameTextures.sharedInstance.meteorCGPath0)
            
        case MeteorType.One:
            self.physicsBody = SKPhysicsBody(polygonFromPath: GameTextures.sharedInstance.meteorCGPath1)
            
        case MeteorType.Two:
            self.physicsBody = SKPhysicsBody(polygonFromPath: GameTextures.sharedInstance.meteorCGPath2)
            
        case MeteorType.Three:
            self.physicsBody = SKPhysicsBody(polygonFromPath: GameTextures.sharedInstance.meteorCGPath3)
            
        case MeteorType.Four:
            self.physicsBody = SKPhysicsBody(polygonFromPath: GameTextures.sharedInstance.meteorCGPath4)
        }
        
        self.physicsBody?.categoryBitMask = Contact.Meteor
        self.physicsBody?.collisionBitMask = 0x0
        self.physicsBody?.contactTestBitMask = 0x0
    }
    
    // MARK: - Update
    func update(delta: NSTimeInterval) {
        
        if kDeviceTablet {
            self.position.y = self.position.y - CGFloat(delta * 60 * 3)
        } else {
            self.position.y = self.position.y - CGFloat(delta * 60 * 2)
        }
        
        self.position.x = self.position.x + self.drift
        
        if self.position.y < (0 - self.size.height) {
            self.removeFromParent()
        }
        
        if self.position.x < (0 - self.size.width) || self.position.x > (kViewSize.width + self.size.width) {
            self.removeFromParent()
        }
    }
    
    func hitMeteor() {
        self.didContact = true
        self.removeFromParent()
    }
    
    func gameOver() {
        self.shader = GameTextures.sharedInstance.shaderPixelate
    }
}
