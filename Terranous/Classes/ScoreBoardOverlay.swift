//
//  ScoreBoardOverlay.swift
//  Terranous
//
//  Created by Jeremy Novak on 7/5/15.
//  Copyright (c) 2015 Jeremy Novak. All rights reserved.
//

import SpriteKit

class GameOver: SKNode {
    
    // MARK: - Private class properties
    private let sharedFonts = GameFonts.sharedInstance
    private let sharedSettings = GameSettings.sharedInstance
    private var background = SKShapeNode()
    private var gameOver = SKSpriteNode()
    
    // MARK: - Public class properties
    internal let retryButton = RetryButton()
    internal let leadersButton = LeadersButton()
    internal let settingsButton = SettingsButton()
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
    }
    
    convenience init(stars: Int, score: Int) {
        self.init()
        
        self.zPosition = GameLayer.Interface
        
        self.setupGameOverBackground()
        self.setupScoreBoard()
        self.displayScore(stars, score: score)
        
        // Game Over text animation
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("animateGameOver"), userInfo: nil, repeats: false)
        
        // Retry Button animation
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("animateRetryButtonIn"), userInfo: nil, repeats: false)
        
        // Leaders Button animation
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("animateLeadersButtonIn"), userInfo: nil, repeats: false)
        
        // Settings Button animation timer
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: Selector("animateSettingsButtonIn"), userInfo: nil, repeats: false)
    }
    
    // MARK: - Setup
    private func setupGameOverBackground() {
        let backgroundSize = CGRectMake(0, 0, kViewSize.width * 0.8, kViewSize.height * 0.25)
        
        self.background = SKShapeNode(rect: backgroundSize, cornerRadius: 5)
        self.background.fillColor = SKColorFromRGB(Colors.Background)
        self.background.strokeColor = SKColor.whiteColor()
        if kDeviceTablet {
            self.background.lineWidth = 6.0
        } else {
            self.background.lineWidth = 3.0
        }
        
        self.background.position = CGPoint(x: kViewSize.width * 0.1, y: kViewSize.height * 0.4)
        
        self.background.alpha = 0.75
        
        self.addChild(self.background)
    }
    
    private func setupScoreBoard() {
        // Game Over
        self.gameOver = GameTextures.sharedInstance.spriteWithName(SpriteName.GameOver)
        self.gameOver.position = CGPoint(x: kScreenCenterHorizontal, y: kViewSize.height * 1.25)
        self.addChild(self.gameOver)
        
        // Scoreboard Label
        let scoreBoardLabel = GameTextures.sharedInstance.spriteWithName(SpriteName.ScoreBoard)
        scoreBoardLabel.position = CGPoint(x: kScreenCenterHorizontal, y: kViewSize.height * 0.6)
        self.addChild(scoreBoardLabel)
        
        // Stars collected Label
        let starsLabel = GameTextures.sharedInstance.spriteWithName(SpriteName.StarsCount)
        starsLabel.position = CGPoint(x: kViewSize.width * 0.2, y: kViewSize.height * 0.5)
        self.addChild(starsLabel)
        
        // Best Stars collected label
        let bestStarsLabel = GameTextures.sharedInstance.spriteWithName(SpriteName.Best)
        bestStarsLabel.position = CGPoint(x: kViewSize.width * 0.6, y: kViewSize.height * 0.5)
        self.addChild(bestStarsLabel)
        
        // Score Label
        let scoreLabel = GameTextures.sharedInstance.spriteWithName(SpriteName.Score)
        scoreLabel.position = CGPoint(x: kViewSize.width * 0.2, y: kViewSize.height * 0.45)
        self.addChild(scoreLabel)
        
        // Best Score Label
        let bestScoreLabel = GameTextures.sharedInstance.spriteWithName(SpriteName.Best)
        bestScoreLabel.position = CGPoint(x: kViewSize.width * 0.6, y: kViewSize.height * 0.45)
        self.addChild(bestScoreLabel)
    }
    
    
    private func displayScore(stars: Int, score: Int) {
        // Stars collected
        let currentStars = GameFonts.sharedInstance.createScoreLabel(stars)
        currentStars.position = CGPoint(x: kViewSize.width * 0.3, y: kViewSize.height * 0.5)
        //currentStars.horizontalAlignment = BMGlyphHorizontalAlignmentLeft
        self.addChild(currentStars)
        
        // Best Stars collected
        let bestStars = GameFonts.sharedInstance.createScoreLabel(GameSettings.sharedInstance.getBestStars())
        bestStars.position = CGPoint(x: kViewSize.width * 0.7, y: kViewSize.height * 0.5)
        //bestStars.horizontalAlignment = BMGlyphHorizontalAlignmentLeft
        self.addChild(bestStars)
        
        // Current Score
        let currentScore = GameFonts.sharedInstance.createScoreLabel(score)
        currentScore.position = CGPoint(x: kViewSize.width * 0.3, y: kViewSize.height * 0.45)
        //currentScore.horizontalAlignment = BMGlyphHorizontalAlignmentLeft
        self.addChild(currentScore)
        
        // Best Score
        let bestScore = GameFonts.sharedInstance.createScoreLabel(GameSettings.sharedInstance.getBestScore())
        bestScore.position = CGPoint(x: kViewSize.width * 0.7, y: kViewSize.height * 0.45)
        //bestScore.horizontalAlignment = BMGlyphHorizontalAlignmentLeft
        self.addChild(bestScore)
    }
    
    // MARK: - Animation Functions
    func animateGameOver() {
        let animateMoveDownShake = SKAction.runBlock({
            self.gameOver.runAction(SKAction.moveTo(CGPoint(x: kScreenCenterHorizontal, y: kViewSize.height * 0.75), duration: 0.25), completion: {
                self.gameOver.runAction(SKAction.screenShakeWithNode(self.gameOver, amount: CGPoint(x: 5.0, y: 10.0), oscillations: 10, duration: 0.5))
            })
        })
        
        animateMoveDownShake.timingMode = SKActionTimingMode.EaseInEaseOut
        
        self.gameOver.runAction(animateMoveDownShake)
    }
    
    func animateSettingsButtonIn() {
        self.addChild(self.settingsButton)
        self.settingsButton.animateSettingsButton()
    }
    
    func animateRetryButtonIn() {
        self.addChild(self.retryButton)
        self.retryButton.animateRetryButton()
    }
    
    func animateLeadersButtonIn() {
        self.addChild(self.leadersButton)
        self.leadersButton.animateLeadersButton()
    }
}

