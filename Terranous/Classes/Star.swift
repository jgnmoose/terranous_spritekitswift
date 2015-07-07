//
//  Star.swift
//  Terranous
//
//  Created by Jeremy Novak on 7/5/15.
//  Copyright (c) 2015 Jeremy Novak. All rights reserved.
//

import SpriteKit

class Star: SKSpriteNode {
    // MARK: - Private class properties
    
    // MARK: - Public class properties
    internal var drift = CGFloat()
    internal var didContact = false
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let texture = SKTexture(imageNamed: SpriteName.Star)
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        
        self.zPosition = GameLayer.Game
        
        self.setupStar()
        self.setupStarPhysics()
        self.setupStarParticles()
        self.setupStarActions()
    }
    
    // MARK: - Setup Functions
    private func setupStar() {
    }
    
    private func setupStarPhysics() {
        self.physicsBody = SKPhysicsBody(polygonFromPath: GameTextures.sharedInstance.starCGPath)
        self.physicsBody?.categoryBitMask = Contact.Star
        self.physicsBody?.collisionBitMask = 0x0
        self.physicsBody?.contactTestBitMask = 0x0
    }
    
    private func setupStarParticles() {
        let particles = GameParticles.sharedInstance.createStarParticles()
        
        particles.position = CGPointZero
        particles.zPosition = self.zPosition - 1
        
        self.addChild(particles)
    }
    
    private func setupStarActions() {
        let scaleUp = SKAction.scaleTo(1.1, duration: 0.25)
        let scaleDown = SKAction.scaleTo(0.9, duration: 0.25)
        let scaleSequence = SKAction.sequence([scaleUp, scaleDown])
        
        self.runAction(SKAction.repeatActionForever(scaleSequence))
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
        
        self.zRotation = self.zRotation + CGFloat(delta)
    }
    
    // MARK: - Action Methods
    func pickedUpStar() {
        didContact = true
        self.removeFromParent()
    }
    
    func gameOver() {
        self.shader = GameTextures.sharedInstance.shaderPixelate
    }
}

