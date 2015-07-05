//
//  SettingsButton.swift
//  Terranous
//
//  Created by Jeremy Novak on 7/5/15.
//  Copyright (c) 2015 Jeremy Novak. All rights reserved.
//


import SpriteKit

class SettingsButton:SKSpriteNode {
    
    // MARK: - Private class properties
    
    // MARK: - Public class properties
    internal var tapped = false
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let settingsButtonTexture = GameTextures.sharedInstance.textureWithName(SpriteName.ButtonSettings)
        self.init(texture: settingsButtonTexture, color: SKColor.whiteColor(), size: settingsButtonTexture.size())
        
        self.setupSettingsButton()
    }
    
    // MARK: - Setup Functions
    private func setupSettingsButton() {
        self.position = CGPoint(x: kViewSize.width - self.size.width / 2, y: kViewSize.height - self.size.height / 2)
        
        self.zPosition = GameLayer.Interface
    }
    
    // MARK: - Animation Functions
    func animateSettingsButton() {
        let angle = RadiansToDegrees(-1.0)
        
        self.alpha = 0
        
        let settingsButtonAnimation = SKAction.fadeInWithDuration(1.0)
        
        settingsButtonAnimation.timingMode = SKActionTimingMode.EaseInEaseOut
        
        self.runAction(settingsButtonAnimation)
    }
    
    // MARK: - Action Functions
    func tappedSettingsButton() {
        self.runAction(GameAudio.sharedInstance.soundPop)
    }
    
}