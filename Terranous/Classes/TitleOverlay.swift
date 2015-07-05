//
//  TitleOverlay.swift
//  Terranous
//
//  Created by Jeremy Novak on 7/5/15.
//  Copyright (c) 2015 Jeremy Novak. All rights reserved.
//

import SpriteKit

class TitleOverlay: SKNode {
    // MARK: - Private class properties
    private var title = SKSpriteNode()
    
    // MARK: - Public class properties
    internal var startButton = SKSpriteNode()
    internal let settingsButton = SettingsButton()
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        
        self.zPosition = GameLayer.Interface
        
        self.setupGameTitle()
        
        // Title and Start Button animation timer
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: Selector(
            "animateGameTitleIn"), userInfo: nil, repeats: false)
        
        // Settings Button animation timer
        NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: Selector("animateSettingsButtonIn"), userInfo: nil, repeats: false)
    }
    
    // MARK: - Setup
    private func setupGameTitle() {
        self.startButton = GameTextures.sharedInstance.spriteWithName(SpriteName.ButtonStart)
        self.startButton.position = CGPoint(x: kScreenCenterHorizontal, y: 0 - self.startButton.size.height)
        self.addChild(self.startButton)
        
        self.title = GameTextures.sharedInstance.spriteWithName(SpriteName.Title)
        self.title.position = CGPoint(x: kScreenCenterHorizontal, y: kViewSize.height * 1.25)
        self.addChild(self.title)
    }
    
    // MARK: - Animation Actions
    func animateGameTitleIn() {
        let titleFirstPosition = CGPoint(x: kScreenCenterHorizontal, y: kViewSize.height * 0.525)
        let titleSecondPosition = CGPoint(x: kScreenCenterHorizontal, y: kViewSize.height * 0.6)
        
        let startFirstPosition = CGPoint(x: kScreenCenterHorizontal, y: kViewSize.height * 0.475)
        let startSecondPosition = CGPoint(x: kScreenCenterHorizontal, y: kViewSize.height * 0.4)
        
        // Title Animation
        let titleAnimation = SKAction.runBlock({
            self.title.runAction(SKAction.moveTo(titleFirstPosition, duration: 0.5), completion: {
                self.title.runAction(SKAction.moveTo(titleSecondPosition, duration: 0.5))
            })
        })
        
        titleAnimation.timingMode = SKActionTimingMode.EaseInEaseOut
        
        self.title.runAction(titleAnimation)
        
        // Start Button Animation
        let startButtonAnimation = SKAction.runBlock({
            self.startButton.runAction(SKAction.moveTo(startFirstPosition, duration: 0.5), completion: {
                self.startButton.runAction(SKAction.moveTo(startSecondPosition, duration: 0.5), completion: {
                    self.startButton.runAction(SKAction.waitForDuration(0.5), completion: {
                        let blink = SKAction.sequence([SKAction.fadeOutWithDuration(0.5), SKAction.fadeInWithDuration(0.5)])
                        self.startButton.runAction(SKAction.repeatActionForever(blink))
                    })
                })
            })
        })
        
        startButtonAnimation.timingMode = SKActionTimingMode.EaseInEaseOut
        
        self.startButton.runAction(startButtonAnimation)
        
    }
    
    func animateSettingsButtonIn() {
        self.addChild(self.settingsButton)
        
        self.settingsButton.animateSettingsButton()
    }
}
