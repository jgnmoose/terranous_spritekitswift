//
//  RetryButton.swift
//  Terranous
//
//  Created by Jeremy Novak on 7/5/15.
//  Copyright (c) 2015 Jeremy Novak. All rights reserved.
//

import SpriteKit

class RetryButton:SKSpriteNode {
    
    // MARK: - Private class properties
    
    // MARK: - Public class properties
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let retryTexture = GameTextures.sharedInstance.textureWithName(SpriteName.ButtonRetry)
        self.init(texture: retryTexture, color: SKColor.whiteColor(), size: retryTexture.size())
        
        self.setupRetryButton()
    }
    
    // MARK: - Setup Functions
    private func setupRetryButton() {
        // Start off screen left
        self.position = CGPoint(x: -kViewSize.width * 1.25, y: kViewSize.height * 0.25)
        
        self.zPosition = GameLayer.Interface
    }
    
    func animateRetryButton() {
        let moveInPop = SKAction.runBlock({
            self.runAction(SKAction.moveTo(CGPoint(x: kViewSize.width * 0.3, y: kViewSize.height * 0.25), duration: 0.25), completion: {
                self.runAction(SKAction.scaleTo(1.25, duration: 0.25), completion: {
                    self.runAction(SKAction.scaleTo(1.0, duration: 0.25))
                })
            })
        })
        
        moveInPop.timingMode = SKActionTimingMode.EaseInEaseOut
        
        self.runAction(moveInPop)
    }
    
    func tappedRetry() {
        self.runAction(GameAudio.sharedInstance.soundPop)
    }
}