//
//  GameOver.swift
//  Terranous
//
//  Created by Jeremy Novak on 7/5/15.
//  Copyright (c) 2015 Jeremy Novak. All rights reserved.
//

import SpriteKit

class GameOver:SKSpriteNode {
    
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
        let texture = SKTexture(imageNamed: SpriteName.GameOver)
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        
        self.setupGameOver()
    }
    
    // MARK: - Setup Functions
    private func setupGameOver() {
        self.position = CGPoint(x: kScreenCenterHorizontal, y: kViewSize.height + self.size.height)
        
        self.zPosition = GameLayer.Interface
    }
    
    // MARK: - Animation Functions
    func animateGameOver() {
        let animateMovePop = SKAction.runBlock({
            self.runAction(SKAction.moveTo(CGPoint(x: kScreenCenterHorizontal, y: kViewSize.height * 0.75), duration: 0.25), completion: {
                self.runAction(SKAction.screenShakeWithNode(self, amount: CGPoint(x: 12, y: 12), oscillations: 8, duration: 0.5))
//                self.runAction(SKAction.scaleTo(1.15, duration: 0.2), completion: {
//                    self.runAction(SKAction.scaleTo(1.0, duration: 0.2))
//                })
            })
        })
        
        self.runAction(animateMovePop)
    }
}