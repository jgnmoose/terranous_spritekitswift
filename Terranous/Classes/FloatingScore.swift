//
//  FloatScore.swift
//  Terranous
//
//  Created by Jeremy Novak on 7/5/15.
//  Copyright (c) 2015 Jeremy Novak. All rights reserved.
//

import SpriteKit

class FloatingScore:SKNode {
    
    // MARK: - Private class properties
    private var score = SKSpriteNode()
    private var bonus = SKSpriteNode()
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        
        self.setupScore()
    }
    
    private func setupScore() {
        self.score = SKSpriteNode(imageNamed: "250")
        self.score.hidden = true
        self.addChild(self.score)
    }
    
    private func setupBonus() {
        self.bonus = SKSpriteNode(imageNamed: "Bonus")
        self.bonus.hidden = true
        self.addChild(self.bonus)
    }
    
    private func floatAction(node: SKSpriteNode) {
        node.runAction(SKAction.runBlock({
            node.hidden = false
            
            node.runAction(SKAction.scaleTo(1.25, duration: 0.25), completion: {
                node.runAction(SKAction.scaleTo(1.5, duration: 0.25), completion: {
                    node.hidden = true
                })
            })
        }))
    }
    
    func floatScore(score: String) {
        if let texture = SKTexture(imageNamed: score) {
            self.score.texture = texture
            self.floatAction(self.score)
        } else {
            return
        }
    }
    
    func floatBonus() {
        self.floatAction(self.bonus)
    }
}
