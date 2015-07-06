//
//  GameParticles.swift
//  Terranous
//
//  Created by Jeremy Novak on 7/5/15.
//  Copyright (c) 2015 Jeremy Novak. All rights reserved.
//

import SpriteKit

let GameParticlesSharedInstance = GameParticles()

class GameParticles {
    
    class var sharedInstance:GameParticles {
        return GameParticlesSharedInstance
    }
    
    // MARK: Private class properties
    private var backgroundParticles = SKEmitterNode()
    private var starParticles = SKEmitterNode()
    private var scoreParticles = SKEmitterNode()
    private var engineParticles = SKEmitterNode()
    
    // MARK: Init
    init() {
        if kDeviceTablet {
            self.backgroundParticles = SKEmitterNode(fileNamed: "BackgroundParticles-iPad")
            self.starParticles = SKEmitterNode(fileNamed: "StarParticle-iPad")
        } else {
            self.backgroundParticles = SKEmitterNode(fileNamed: "BackgroundParticles-iPhone")
            self.starParticles = SKEmitterNode(fileNamed: "StarParticle-iPhone")
            self.scoreParticles = SKEmitterNode(fileNamed: "ScoreParticle-iPhone")
        }
    }
    
    func createBackgroundParticles() -> SKEmitterNode {
        return self.backgroundParticles.copy() as! SKEmitterNode
    }
    
    func createStarParticles() -> SKEmitterNode {
        return self.starParticles.copy() as! SKEmitterNode
    }
    
    func createScoreParticles() -> SKEmitterNode {
        return self.scoreParticles.copy() as! SKEmitterNode
    }
}
