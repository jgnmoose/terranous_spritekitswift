//
//  Background.swift
//  Terranous
//
//  Created by Jeremy Novak on 7/5/15.
//  Copyright (c) 2015 Jeremy Novak. All rights reserved.
//

import SpriteKit

class Background:SKNode {
    
    // MARK: - Private class properites
    
    // MARK: - Public class properties
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        
        self.setupBackground()
    }
    
    // MARK: - Setup
    private func setupBackground() {
        let backgroundParticles = GameParticles.sharedInstance.createBackgroundParticles()
        self.addChild(backgroundParticles)
    }
    
}