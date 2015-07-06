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
        let texture = SKTexture(imageNamed: SpriteName.ButtonTap)
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        
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
