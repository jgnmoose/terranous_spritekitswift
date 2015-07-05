//
//  TapButton.swift
//  Terranous
//
//  Created by Jeremy Novak on 7/5/15.
//  Copyright (c) 2015 Jeremy Novak. All rights reserved.
//

import SpriteKit

class TapButton:SKSpriteNode {
    
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
        let tapButtonTexture = GameTextures.sharedInstance.textureWithName(SpriteName.ButtonTap)
        self.init(texture: tapButtonTexture, color: SKColor.whiteColor(), size: tapButtonTexture.size())
        
        self.setupTapButton()
    }
    
    // MARK: - Setup Functions
    private func setupTapButton() {
        self.position = CGPoint(x: kScreenCenterHorizontal, y: kScreenCenterVertical)
        
        self.zPosition = GameLayer.Interface
    }
    
    // MARK: - Action Functions
    func tapped() {
        self.runAction(GameAudio.sharedInstance.soundPop, completion: {
            self.runAction(SKAction.fadeAlphaTo(0, duration: 0.5), completion: {
                self.removeFromParent()
            })
        })
    }
    
}
