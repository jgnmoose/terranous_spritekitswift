//
//  GameFonts.swift
//  Terranous
//
//  Created by Jeremy Novak on 7/5/15.
//  Copyright (c) 2015 Jeremy Novak. All rights reserved.
//

import SpriteKit

let GameFontsSharedInstance = GameFonts()

class GameFonts {
    
    class var sharedInstance:GameFonts {
        return GameFontsSharedInstance
    }
    
    // MARK: - Private class properties
    private var scoreLabel = SKLabelNode()
    private var floatScoreLabel = SKLabelNode()
    private var floatScoreLabelAction = SKAction()
    private var bonusLabel = SKLabelNode()
    private var bonusLabelAction = SKAction()
    
    // MARK: - Public class properties
    
    // MARK: - Init
    init() {
        self.setupScoreLabel()
        self.setupFloatScoreLabel()
        self.setupBonusLabel()
    }
    
    // MARK: - Setup
    private func setupScoreLabel() {
        self.scoreLabel = SKLabelNode(fontNamed: kFontName)
        self.scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center
        self.scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        self.scoreLabel.fontColor = SKColorFromRGB(Colors.ScoreFont)
        
        if kDeviceTablet {
            self.scoreLabel.fontSize = 36.0
        } else {
            self.scoreLabel.fontSize = 18.0
        }
    }
    
    private func setupFloatScoreLabel() {
        self.floatScoreLabel = SKLabelNode(fontNamed: kFontName)
        self.floatScoreLabel.fontColor = SKColor.greenColor()
        
        if kDeviceTablet {
            self.floatScoreLabel.fontSize = 48
        } else {
            self.floatScoreLabel.fontSize = 24
        }
    }
    
    private func setupBonusLabel() {
        self.bonusLabel = SKLabelNode(fontNamed: kFontName)
        self.floatScoreLabel.fontColor = SKColor.greenColor()
        
        if kDeviceTablet {
            self.bonusLabel.fontSize = 48
        } else {
            self.bonusLabel.fontSize = 24
        }
    }
    
    // MARK: - Public functions
    func createScoreLabel(score: Int) -> SKLabelNode {
        self.scoreLabel.text = String(score)
        return self.scoreLabel.copy() as! SKLabelNode
    }

    
    func createFloatScoreLabel() -> SKLabelNode {
        return self.floatScoreLabel.copy() as! SKLabelNode
    }
    
    func createBonusLabel() -> SKLabelNode {
        return self.bonusLabel.copy() as! SKLabelNode
    }
    
    func animateFloatingScore(node: SKLabelNode) -> SKAction {
        let action = SKAction.runBlock({
            node.runAction(SKAction.fadeInWithDuration(0.1), completion: {
                node.runAction(SKAction.scaleTo(1.25, duration: 0.1), completion: {
                    node.runAction(SKAction.moveToY(node.position.y + node.frame.size.height, duration: 0.1), completion: {
                        node.runAction(SKAction.fadeOutWithDuration(0.1), completion: {
                            node.removeFromParent()
                        })
                    })
                })
            })
        })
        
        action.timingMode = SKActionTimingMode.EaseInEaseOut
        
        return action
    }

}

