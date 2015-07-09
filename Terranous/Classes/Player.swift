//
//  Player.swift
//  Terranous
//
//  Created by Jeremy Novak on 7/5/15.
//  Copyright (c) 2015 Jeremy Novak. All rights reserved.
//

import SpriteKit
import GameKit

class Player: SKSpriteNode {
    
    // MARK: - Private class properties
    private var canMove = false
    private var targetLocation = CGPoint()
    private var originLocation = CGPoint()
    private var filterFactor = CGFloat()
    private var touchOffsetY = CGFloat()
    private var streakCount = 0
    
    // MARK: - Public class properties
    internal var lives = 3
    internal var score = 0
    internal var stars = 0
    internal var immune = false
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    
    convenience init() {
        //let playerTexture = GameTextures.sharedInstance.textureWithName(SpriteName.Player)
        let texture = SKTexture(imageNamed: SpriteName.Player)
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        
        self.position = CGPoint(x: kScreenCenterHorizontal, y: kViewSize.height * 0.25)
        
        self.zPosition = GameLayer.Game
        
        self.setupPlayer()
        self.setupPlayerPhysics()
        self.setupEngineParticles()
    }
    
    // MARK: - Setup Functions
    private func setupPlayer() {
        self.targetLocation = self.position
        
        self.touchOffsetY = 32.0
        
        self.filterFactor = 0.05
    }
    
    private func setupPlayerPhysics() {
        self.physicsBody = SKPhysicsBody(polygonFromPath: GameTextures.sharedInstance.playerCGPath)
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = Contact.Player
        self.physicsBody?.collisionBitMask = Contact.Scene
        self.physicsBody?.contactTestBitMask = Contact.Star | Contact.Meteor
    }
    
    private func setupEngineParticles() {
        let particles = GameParticles.sharedInstance.createEngineParticles()
        particles.zPosition = self.zPosition - 1
        self.addChild(particles)
    }
    
    
    // MARK: - Enable/Disable Movement
    func enableMovement() {
        self.canMove = true
        
        self.runAction(GameAudio.sharedInstance.soundEngineStart)
    }
    
    func disableMovement() {
        self.canMove = false
        self.targetLocation = CGPointZero
    }
    
    // MARK: - Movement
    func updateTargetLocation(newLocation: CGPoint) {
        self.targetLocation = CGPoint(x: newLocation.x, y: newLocation.y + self.touchOffsetY)
    }
    
    private func move() {
        let newX = Smooth(self.position.x, self.targetLocation.x, self.filterFactor)
        let newY = Smooth(self.position.y, self.targetLocation.y, self.filterFactor)
        
        self.position = CGPoint(x: newX, y: newY)
    }
    
    // MARK: - Update
    func update(delta: NSTimeInterval) {
        if self.canMove {
            self.move()
        }
    }
    
    func updatePlayerLives() {
        self.lives -= 1
    }
    
    func updatePlayerStars() {
        self.stars += 1
    }
    
    func updatePlayerScore(score: Int) {
        self.score += score
    }
    
    // MARK: - Action Functions
    func pickedUpStar() {
        
        var floatScore = GameFonts.sharedInstance.createFloatScoreLabel()
        
        self.stars += 1
        
        self.streakCount += 1
        
        switch self.streakCount {
        case 0..<5:
            self.score += 250
            floatScore.text = String(250)
            
        case 5..<10:
            self.score += 500
            floatScore.text = String(500)
            
        case 10..<15:
            self.score += 750
            floatScore.text = String(750)
            
        case 15..<20:
            self.score += 1000
            floatScore.text = String(1000)
            
        case 20..<25:
            self.score += 1250
            floatScore.text = String(1250)
            
        case 25..<30:
            self.score += 1500
            floatScore.text = String(1500)
            
        case 30..<35:
            self.score += 1750
            floatScore.text = String(1750)
            
        case 35..<40:
            self.score += 2000
            floatScore.text = String(2000)
            
        case 40..<45:
            self.score += 2250
            floatScore.text = String(2250)
            
        case 45..<50:
            self.score += 2500
            floatScore.text = String(2500)
            
        default:
            self.score += 5000
            floatScore.text = String(5000)
        }

        floatScore.position = self.position
        self.parent?.addChild(floatScore)
        
        floatScore.runAction(GameFonts.sharedInstance.animateFloatingScore(floatScore))
        
        self.runAction(GameAudio.sharedInstance.soundScore)
        
        if self.streakCount < 50 {
            if self.streakCount % 5 == 0 {
                var bonus = GameFonts.sharedInstance.createBonusLabel()
                bonus.position = kScreenCenter
                bonus.text = "Bonus!"
                
                self.parent?.addChild(bonus)
                bonus.runAction(GameFonts.sharedInstance.animateBonus(bonus))
                
                self.runAction(GameAudio.sharedInstance.soundBonus)
            }
        } else {
            if self.streakCount % 50 == 0 {
                var bonus = GameFonts.sharedInstance.createBonusLabel()
                bonus.position = kScreenCenter
                bonus.text = "Max Bonus!"
                
                self.parent?.addChild(bonus)
                bonus.runAction(GameFonts.sharedInstance.animateBonus(bonus))
                
                self.runAction(GameAudio.sharedInstance.soundBonusMax)
            }
        }
    }
    
    func rewindPlayer() {
        self.enablePlayerImmunity()
        
        self.runAction(SKAction.runBlock({
            self.animateExplosion()
            self.runAction(GameAudio.sharedInstance.soundExplode, completion: {
                self.runAction(GameAudio.sharedInstance.soundDestroyed)
            })
        }))
        
        
        self.runAction(SKAction.runBlock({
            self.hidden = true
            self.streakCount = 0
            self.disableMovement()
            self.targetLocation = CGPoint(x: kScreenCenterHorizontal, y: kViewSize.height * 0.25)
            self.runAction(SKAction.moveTo(self.targetLocation, duration: 0), completion: {
                self.hidden = false
                self.runAction(SKAction.waitForDuration(0.25), completion: {
                    self.enableMovement()
                })
            })
        }))
        
        self.runAction(SKAction.waitForDuration(3.0), completion: {
            self.disablePlayerImmunity()
        })
    }
    
    private func blinkPlayer() {
        let blink = SKAction.sequence([SKAction.fadeOutWithDuration(0.15), SKAction.fadeInWithDuration(0.15)])
        self.runAction(SKAction.repeatActionForever(blink))
    }
    
    private func enablePlayerImmunity() {
        self.immune = true
        self.blinkPlayer()
    }
    
    private func disablePlayerImmunity() {
        self.immune = false
        self.removeAllActions()
        self.alpha = 1.0
    }
    
    private func animateExplosion() {
        let explodeTexture = SKSpriteNode(imageNamed: "Explosion0")
        explodeTexture.position = self.position
        self.parent?.addChild(explodeTexture)
        
        let animateExplode = SKAction.runBlock({
            explodeTexture.runAction(SKAction.animateWithTextures(GameTextures.sharedInstance.explosionTextures, timePerFrame: 0.025), completion: {
                explodeTexture.removeFromParent()
            })
        })
        
        explodeTexture.runAction(animateExplode)
        
    }
    
    func destroyPlayer() {
        self.runAction(GameAudio.sharedInstance.soundExplode, completion: {
            self.runAction(GameAudio.sharedInstance.soundDestroyed)
        })
        
        self.shader = GameTextures.sharedInstance.shaderPixelate
        
        self.physicsBody?.allowsRotation = true
        
        let randomVecX = RandomFloatRange(-5, 5)
        let randomVecY = RandomFloatRange(-5, 5)
        
        self.physicsBody?.applyImpulse(CGVectorMake(randomVecX, randomVecY))
    }
    
    func checkPlayerBestScore() {
        if self.score > GameSettings.sharedInstance.getBestScore() || GameSettings.sharedInstance.getBestScore() == 0 {
            GameSettings.sharedInstance.saveBestScore(self.score)
            
            if GameKitHelper.sharedInstance.enableGameCenter {
                if GKLocalPlayer.localPlayer().authenticated {
                    GKLocalPlayer.localPlayer().loadDefaultLeaderboardIdentifierWithCompletionHandler({ (leaderboardIdentifier : String!, error : NSError!) -> Void in
                        let score = GKScore(leaderboardIdentifier: leaderboardIdentifier)
                        score.value = Int64(GameSettings.sharedInstance.getBestScore())
                        
                        GKScore.reportScores([score], withCompletionHandler: { (error : NSError!) -> Void in
                            if kDebug {
                                if error != nil {
                                    println("Error: " + error.localizedDescription)
                                } else {
                                    println("Score sent to Game Center: \(score.value)")
                                }
                                
                            }
                        })
                    })
                }
            }

        }
        
        if self.stars > GameSettings.sharedInstance.getBestStars() || GameSettings.sharedInstance.getBestStars() == 0 {
            GameSettings.sharedInstance.saveStarsCollected(self.stars)
        }
    }
}
