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
    }
    
    // MARK: - Setup
    private func setupScoreLabel() {
        self.scoreLabel = SKLabelNode(fontNamed: "Edit Undo BRK")
        self.scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center
        self.scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        self.scoreLabel.fontColor = SKColor.whiteColor()
        
        if kDeviceTablet {
            self.scoreLabel.fontSize = 36.0
        } else {
            self.scoreLabel.fontSize = 18.0
        }
    }
    
    func createScoreLabel(score: Int) -> SKLabelNode {
        self.scoreLabel.text = String(score)
        return self.scoreLabel.copy() as! SKLabelNode
    }

}

