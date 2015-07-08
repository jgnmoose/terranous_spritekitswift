//
//  StatusBar.swift
//  Terranous
//
//  Created by Jeremy Novak on 7/5/15.
//  Copyright (c) 2015 Jeremy Novak. All rights reserved.
//

import SpriteKit

class StatusBar: SKNode {
    // MARK: - Private class properites
    private var statusBarBackground:SKSpriteNode!
    private var starsCollectedLabel = SKLabelNode()
    private var starsCollected = SKSpriteNode()
    private var scoreLabel = SKLabelNode()
    
    // MARK: - Public class properties
    internal let pauseButton = PauseButton()
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
    }
    
    convenience init(viewSize: CGSize, lives: Int, starsCollected: Int, score: Int) {
        self.init()
        
        self.zPosition = GameLayer.Interface
        
        self.setupStatusBarBackground()
        self.setupStatusBarStarsCollected(starsCollected)
        self.setupStatusBarScore(score)
        self.setupPauseButton()
        
        self.updateLives(lives)
    }
    
    // MARK: - Setup Functions
    private func setupStatusBarBackground() {
        let statusBarBackgroundSize = CGSizeMake(kViewSize.width, kViewSize.height * 0.055)
        self.statusBarBackground = SKSpriteNode(color: SKColor.blackColor(), size: statusBarBackgroundSize)
        
        self.statusBarBackground.anchorPoint = CGPointZero
        self.statusBarBackground.position = CGPoint(x: 0, y: kViewSize.height * 0.945)
        
        self.addChild(self.statusBarBackground)
    }
    
    private func setupStatusBarStarsCollected(collected: Int) {
        // Stars Collected Sprite
        self.starsCollected = GameTextures.sharedInstance.spriteWithName(SpriteName.StarsCollected)
        
        let starOffsetX = self.statusBarBackground.size.width / 2 - self.starsCollected.size.width * 2
        let starOffsetY = self.statusBarBackground.size.height / 2
        
        self.starsCollected.position = CGPoint(x: starOffsetX, y: starOffsetY)
        
        
        // Stars Collected Label
        self.starsCollectedLabel = GameFonts.sharedInstance.createScoreLabel(collected)
        
        let labelOffsetX = self.statusBarBackground.size.width / 2
        let labelOffsetY = self.statusBarBackground.size.height / 2
        
        self.starsCollectedLabel.position = CGPoint(x: labelOffsetX, y: labelOffsetY)
        
        self.statusBarBackground.addChild(self.starsCollected)
        self.statusBarBackground.addChild(self.starsCollectedLabel)
    }
    
    private func setupStatusBarScore(score: Int) {
        self.scoreLabel = GameFonts.sharedInstance.createScoreLabel(score)
        
        let offsetX = self.statusBarBackground.size.width * 0.7
        let offsetY = self.statusBarBackground.size.height / 2
        
        self.scoreLabel.position = CGPoint(x: offsetX, y: offsetY)
        
        self.statusBarBackground.addChild(self.scoreLabel)
    }
    
    private func setupPauseButton() {
        self.addChild(self.pauseButton)
    }
    
    
    func updateLives(lives: Int) {
        self.statusBarBackground.enumerateChildNodesWithName("LivesSprite") { node, _ in
            if let livesSprite = node as? SKSpriteNode {
                livesSprite.removeFromParent()
            }
        }
        
        var offsetX = CGFloat()
        var offsetY = self.statusBarBackground.size.height / 2
        
        for var i = 0; i < lives; i++ {
            let livesSprite = GameTextures.sharedInstance.spriteWithName(SpriteName.PlayerLives)
            
            offsetX = livesSprite.size.width + livesSprite.size.width * 1.5 * CGFloat(i)
            
            livesSprite.position = CGPoint(x: offsetX, y: offsetY)
            
            livesSprite.name = "LivesSprite"
            
            self.statusBarBackground.addChild(livesSprite)
        }
    }
    
    func updateStarsCollected(collected: Int, score: Int) {
        self.starsCollectedLabel.text = String(collected)
        
        let scaleUp = SKAction.scaleTo(1.5, duration: 0.12)
        let scaleNormal = SKAction.scaleTo(1.0, duration: 0.12)
        let scaleSequence = SKAction.sequence([scaleUp, scaleNormal])
        
        self.starsCollected.runAction(scaleSequence)
        
        self.scoreLabel.runAction(scaleSequence)
        
        self.updateScore(score)
    }
    
    func updateScore(score: Int) {
        self.scoreLabel.text = String(score)
    }
}
