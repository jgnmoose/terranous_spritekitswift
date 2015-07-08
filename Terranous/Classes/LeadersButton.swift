//
//  LeadersButton.swift
//  Terranous
//
//  Created by Jeremy Novak on 7/5/15.
//  Copyright (c) 2015 Jeremy Novak. All rights reserved.
//

import SpriteKit

class LeadersButton:SKSpriteNode {
    
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
        let texture = SKTexture(imageNamed: SpriteName.ButtonLeaders)
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        
        self.setupLeadersButton()
    }
    
    // MARK: - Setup Functions
    private func setupLeadersButton() {
        // Start off screen right
        self.position = CGPoint(x: kScreenCenterHorizontal, y: kViewSize.height * 0.4)
        
        self.zPosition = GameLayer.Interface
    }
    
    func animateLeadersButton() {
        let fadeInPop = SKAction.runBlock({
            self.runAction(SKAction.fadeInWithDuration(0.25), completion: {
                self.runAction(SKAction.scaleTo(1.25, duration: 0.25), completion: {
                    self.runAction(SKAction.scaleTo(1.0, duration: 0.25))
                })
            })
        })
        
        self.runAction(fadeInPop)
    }
    
    func tappedLeaders() {
        self.runAction(GameAudio.sharedInstance.soundPop)
    }
}