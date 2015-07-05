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
    private var scoreLabelAction = SKAction()
    
    // MARK: - Public class properties
    
    // MARK: - Init
    init() {
        self.setupScoreLabel()
        self.setupScoreLabelAction()
    }
    
    // MARK: - Setup
    private func setupScoreLabel() {
        self.scoreLabel = SKLabelNode(fontNamed: "Edit Undo BRK")
        self.scoreLabel.fontColor = SKColor.whiteColor()
        
        if kDeviceTablet {
            self.scoreLabel.fontSize = 36.0
        } else {
            self.scoreLabel.fontSize = 18.0
        }
    }
    
    private func setupScoreLabelAction() {
        self.scoreLabelAction = SKAction.runBlock({
            (SKAction.scaleTo(1.5, duration: 0.25), completion: {
                (SKAction.moveToY(75, duration: 0.5), completion: {
                    (SKAction.fadeAlphaTo(0.0, duration: 0.5), completion: {
                        SKAction.removeFromParent()
                    })
                })
            })
        })
        
        self.scoreLabelAction.timingMode = SKActionTimingMode.EaseInEaseOut
    }
    
    func createScoreLabel(score: Int) -> SKLabelNode {
        return self.scoreLabel.copy() as! SKLabelNode
    }

}

