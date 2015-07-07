//
//  StarController.swift
//  Terranous
//
//  Created by Jeremy Novak on 7/5/15.
//  Copyright (c) 2015 Jeremy Novak. All rights reserved.
//

import SpriteKit

class StarController: SKNode {
    // MARK: - Private class properties
    private var sendingStars = false
    private var movingStars = false
    private var frameCount = 0.0
    private let star = Star()
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        
        self.setupStarController()
    }
    
    // MARK: - Setup Functions
    private func setupStarController() {
    }
    
    // MARK: - Action Functions
    func sendStars() {
        if self.sendingStars {
            let startX = RandomFloatRange(0, kViewSize.width)
            let startY = kViewSize.height * 1.25
            
            let randomVecX = RandomFloatRange(-0.25, 0.25)
            
            let starCopy = self.star.copy() as! Star
            starCopy.position = CGPoint(x: startX, y: startY)
            starCopy.drift = RandomFloatRange(-0.25, 0.25)
            self.addChild(starCopy)
        }
    }
    
    func startSendingStars() {
        self.sendingStars = true
        self.movingStars = true
    }
    
    func stopSendingStars() {
        self.sendingStars = false
        self.movingStars = false
        
        self.frameCount = 0.0
    }
    
    
    // MARK: - Update
    func update(delta: NSTimeInterval) {
        if self.sendingStars {
            self.frameCount += delta
            
            if self.frameCount >= 3.0 {
                self.sendStars()
                
                self.frameCount = 0.0
            }
        }
        
        if self.movingStars {
            for node in self.children {
                if let star = node as? Star {
                    star.update(delta)
                }
            }
        }
    }
    
    // MARK: - Action Functions
    func gameOver() {
        for node in self.children {
            if let star = node as? Star {
                star.gameOver()
            }
        }
    }
}

