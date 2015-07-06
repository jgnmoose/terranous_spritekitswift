//
//  StartButton.swift
//  Terranous
//
//  Created by Jeremy Novak on 7/5/15.
//  Copyright (c) 2015 Jeremy Novak. All rights reserved.
//

import SpriteKit

class StartButton:SKSpriteNode {
    
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
        let texture = GameTextures.sharedInstance.textureWithName(SpriteName.ButtonStart)
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        
        self.setupStartButton()
    }
    
    // MARK: - Setup Functions
    private func setupStartButton() {
        self.position = CGPoint(x: kScreenCenterHorizontal, y: 0 - self.size.height)
        
        self.zPosition = GameLayer.Interface
    }
    
    // MARK: - Action Functions
    func animateStartButton() {
        let startFirstPosition = CGPoint(x: kScreenCenterHorizontal, y: kViewSize.height * 0.475)
        let startSecondPosition = CGPoint(x: kScreenCenterHorizontal, y: kViewSize.height * 0.4)
        
        let startButtonAnimation = SKAction.runBlock({
            self.runAction(SKAction.moveTo(startFirstPosition, duration: 0.5), completion: {
                self.runAction(SKAction.moveTo(startSecondPosition, duration: 0.5), completion: {
                    self.runAction(SKAction.waitForDuration(0.5), completion: {
                        let blink = SKAction.sequence([SKAction.fadeOutWithDuration(0.5), SKAction.fadeInWithDuration(0.5)])
                        self.runAction(SKAction.repeatActionForever(blink))
                    })
                })
            })
        })
        
        startButtonAnimation.timingMode = SKActionTimingMode.EaseInEaseOut
        
        self.runAction(startButtonAnimation)
    }
    
    func tapped() {
        self.runAction(GameAudio.sharedInstance.soundPop)
    }
    
}