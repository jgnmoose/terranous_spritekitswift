//
//  PauseButton.swift
//  Terranous
//
//  Created by Jeremy Novak on 7/5/15.
//  Copyright (c) 2015 Jeremy Novak. All rights reserved.
//

import SpriteKit

class PauseButton:SKSpriteNode {
    
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
        let settingsButtonTexture = GameTextures.sharedInstance.textureWithName(SpriteName.ButtonPause)
        self.init(texture: settingsButtonTexture, color: SKColor.whiteColor(), size: settingsButtonTexture.size())
        
        self.setupPauseButton()
    }
    
    // MARK: - Setup Functions
    private func setupPauseButton() {
        self.position = CGPoint(x: kViewSize.width - self.size.width / 2, y: kViewSize.height - self.size.height / 2)
        
        self.zPosition = GameLayer.Interface
    }
    
    // MARK: - Action Functions
    func tappedPauseButton() {
        self.runAction(GameAudio.sharedInstance.soundPop)
        
        self.tapped = !self.tapped
        
        let pauseTexture = GameTextures.sharedInstance.textureWithName(SpriteName.ButtonPause)
        let resumeTexture = GameTextures.sharedInstance.textureWithName(SpriteName.ButtonResume)
        
        self.texture = self.tapped ? resumeTexture : pauseTexture
    }
    
}