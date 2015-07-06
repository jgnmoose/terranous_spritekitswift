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
    private let title = Title()
    
    // MARK: - Public class properties
    internal let startButton = StartButton()
    internal let settingsButton = SettingsButton()
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        
        self.zPosition = GameLayer.Interface
        
        self.setupTitleOverlay()
        
        // Title and Start Button animation timer
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: Selector(
            "animateTitleIn"), userInfo: nil, repeats: false)
        
        // Settings Button animation timer
        NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: Selector("animateSettingsButtonIn"), userInfo: nil, repeats: false)
    }
    
    // MARK: - Setup
    private func setupTitleOverlay() {
        self.addChild(self.startButton)
        
        self.addChild(self.title)
    }
    
    // MARK: - Animation Actions
    func animateTitleIn() {
        self.title.animateTitle()
        self.startButton.animateStartButton()
    }
    
    func animateSettingsButtonIn() {
        self.addChild(self.settingsButton)
        
        self.settingsButton.animateSettingsButton()
    }
}
