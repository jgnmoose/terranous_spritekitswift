//
//  ScoreBoardOverlay.swift
//  Terranous
//
//  Created by Jeremy Novak on 7/5/15.
//  Copyright (c) 2015 Jeremy Novak. All rights reserved.
//

import SpriteKit

class ScoreBoard: SKNode {
    
    // MARK: - Private class properties
    private let sharedFonts = GameFonts.sharedInstance
    private let sharedSettings = GameSettings.sharedInstance
    private var background = SKShapeNode()
    private let gameOver = GameOver()
    
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
//        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("animateLeadersButtonIn"), userInfo: nil, repeats: false)
        
        // Settings Button animation timer
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: Selector("animateSettingsButtonIn"), userInfo: nil, repeats: false)
    }
    
    // MARK: - Setup
    private func setupGameOverBackground() {
        let backgroundSize = CGRectMake(0, 0, kViewSize.width * 0.8, kViewSize.height * 0.3)
        
        self.background = SKShapeNode(rect: backgroundSize, cornerRadius: 5)
        self.background.fillColor = SKColorFromRGB(Colors.Background)
        self.background.strokeColor = SKColor.whiteColor()
        if kDeviceTablet {
            self.background.lineWidth = 6.0
        } else {
            self.background.lineWidth = 3.0
        }
        
        self.background.position = CGPoint(x: kViewSize.width * 0.1, y: kViewSize.height * 0.35)
        
        self.background.alpha = 0.75
        
        self.addChild(self.background)
    }
    
    private func setupScoreBoard() {
        // Scoreboard Label
        let scoreBoardLabel = GameTextures.sharedInstance.spriteWithName(SpriteName.ScoreBoard)
        scoreBoardLabel.position = CGPoint(x: kScreenCenterHorizontal, y: kViewSize.height * 0.6)
        self.addChild(scoreBoardLabel)
        
        // Stars collected Label
        let starsLabel = GameTextures.sharedInstance.spriteWithName(SpriteName.StarsCount)
        starsLabel.position = CGPoint(x: kViewSize.width * 0.2, y: kViewSize.height * 0.525)
        self.addChild(starsLabel)
        
        // Best Stars collected label
        let bestStarsLabel = GameTextures.sharedInstance.spriteWithName(SpriteName.Best)
        bestStarsLabel.position = CGPoint(x: kViewSize.width * 0.6, y: kViewSize.height * 0.525)
        self.addChild(bestStarsLabel)
        
        // Score Label
        let scoreLabel = GameTextures.sharedInstance.spriteWithName(SpriteName.Score)
        scoreLabel.position = CGPoint(x: kViewSize.width * 0.2, y: kViewSize.height * 0.475)
        self.addChild(scoreLabel)
        
        // Best Score Label
        let bestScoreLabel = GameTextures.sharedInstance.spriteWithName(SpriteName.Best)
        bestScoreLabel.position = CGPoint(x: kViewSize.width * 0.6, y: kViewSize.height * 0.475)
        self.addChild(bestScoreLabel)
        
        self.addChild(self.leadersButton)
    }
    
    
    private func displayScore(stars: Int, score: Int) {
        // Stars collected
        let currentStars = GameFonts.sharedInstance.createScoreLabel(stars)
        currentStars.position = CGPoint(x: kViewSize.width * 0.3, y: kViewSize.height * 0.525)
        //currentStars.horizontalAlignment = BMGlyphHorizontalAlignmentLeft
        self.addChild(currentStars)
        
        // Best Stars collected
        let bestStars = GameFonts.sharedInstance.createScoreLabel(GameSettings.sharedInstance.getBestStars())
        bestStars.position = CGPoint(x: kViewSize.width * 0.7, y: kViewSize.height * 0.525)
        //bestStars.horizontalAlignment = BMGlyphHorizontalAlignmentLeft
        self.addChild(bestStars)
        
        // Current Score
        let currentScore = GameFonts.sharedInstance.createScoreLabel(score)
        currentScore.position = CGPoint(x: kViewSize.width * 0.3, y: kViewSize.height * 0.475)
        //currentScore.horizontalAlignment = BMGlyphHorizontalAlignmentLeft
        self.addChild(currentScore)
        
        // Best Score
        let bestScore = GameFonts.sharedInstance.createScoreLabel(GameSettings.sharedInstance.getBestScore())
        bestScore.position = CGPoint(x: kViewSize.width * 0.7, y: kViewSize.height * 0.475)
        //bestScore.horizontalAlignment = BMGlyphHorizontalAlignmentLeft
        self.addChild(bestScore)
    }
    
    // MARK: - Animation Functions
    func animateGameOver() {
        self.addChild(self.gameOver)
        self.gameOver.animateGameOver()
    }
    
    func animateSettingsButtonIn() {
        self.addChild(self.settingsButton)
        self.settingsButton.animateSettingsButton()
    }
    
    func animateRetryButtonIn() {
        self.addChild(self.retryButton)
        self.retryButton.animateRetryButton()
    }
    
//    func animateLeadersButtonIn() {
//        self.addChild(self.leadersButton)
//        self.leadersButton.animateLeadersButton()
//    }
}

