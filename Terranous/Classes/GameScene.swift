//
//  GameScene.swift
//  Terranous
//
//  Created by Jeremy Novak on 7/5/15.
//  Copyright (c) 2015 Jeremy Novak. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // MARK: - Private class properties
    private let gameNode = SKNode()
    private let statusBarNode = SKNode()
    private var tapButton = TapButton()
    private var player = Player()
    private var meteorController = MeteorController()
    private var starController = StarController()
    private var statusBar = StatusBar()
    private var gameOver = GameOver()
    // State
    private var state = GameState.Tutorial
    // Time/Frame Tracking
    private var lastUpdateTime:NSTimeInterval = 0;
    // Timer
    private var frameCount:NSTimeInterval = 0.0
    
    private enum GameState:Int {
        case Tutorial
        case Running
        case GameOver
    }
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    override func didMoveToView(view: SKView) {
        GameAudio.sharedInstance.playBackgroundMusic(Music.Intro)
        
        #if FREE
        NSNotificationCenter.defaultCenter().postNotificationName("AdBannerHide", object: nil)
        #endif
        
        self.setupGameScene()
    }
    
    // MARK: - Setup
    private func setupGameScene() {
        self.backgroundColor = SKColorFromRGB(Colors.Background)
        
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        self.physicsWorld.contactDelegate = self
        
        let screenBounds = CGRectMake(0, 0, kViewSize.width, kViewSize.height * 0.945)
        self.gameNode.physicsBody = SKPhysicsBody(edgeLoopFromRect:screenBounds)
        self.gameNode.physicsBody?.categoryBitMask = Contact.Scene
        self.addChild(self.gameNode)
        
        let background = Background()
        self.gameNode.addChild(background)
        
        self.gameNode.addChild(self.player)
        
        self.gameNode.addChild(self.meteorController)
        
        self.gameNode.addChild(self.starController)
        
        self.addChild(self.statusBarNode)
        
        self.statusBar = StatusBar(viewSize: kViewSize, lives: player.lives, starsCollected: 0, score: 0)
        self.statusBarNode.addChild(self.statusBar)
        
        self.switchToTutorial()
    }
    
    // MARK: - Touch Events
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch:UITouch = touches.first as! UITouch
        let touchLocation = touch.locationInNode(self)
        
        switch state {
        case GameState.Tutorial:
            if self.tapButton.containsPoint(touchLocation) {
                self.switchToRunning()
            }
            
            if self.statusBar.pauseButton.containsPoint(touchLocation) {
                self.pauseButtonPressed()
            }
            
        case GameState.Running:
            if self.statusBar.pauseButton.containsPoint(touchLocation) {
                self.pauseButtonPressed()
            } else {
                self.player.updateTargetLocation(touchLocation)
            }
            
            
        case GameState.GameOver:
            return
        }
    }
    
    // MARK: - Update
    override func update(currentTime: NSTimeInterval) {
        let delta = currentTime - self.lastUpdateTime
        self.lastUpdateTime = currentTime
        
        switch state {
        case GameState.Tutorial:
            return
            
        case GameState.Running:
            if !self.statusBar.pauseButton.tapped {
                if self.player.lives > 0 {
                    // Update game objects
                    self.player.update(delta)
                    self.statusBar.updateScore(self.player.score)
                    self.meteorController.update(delta)
                    self.starController.update(delta)
                    
                    // Count frames for distance tick
                    self.frameCount += delta
                    
                    if self.frameCount >= 1.0 {
                        self.updateDistanceTickScore()
                        self.frameCount = 0.0
                    }
                    
                } else {
                    self.switchToGameOver()
                }
            }
            
        case GameState.GameOver:
            return
            
        }
    }
    
    // MARK: - Contact
    func didBeginContact(contact: SKPhysicsContact) {
        if self.state == GameState.Tutorial || self.state == GameState.GameOver {
            return
        } else {
            var other = contact.bodyA.categoryBitMask == Contact.Player ? contact.bodyB : contact.bodyA
            
            if other.categoryBitMask == Contact.Meteor {
                // Player hit a meteor
                if let meteor = other.node as? Meteor {
                    if !self.player.immune {
                        if self.player.lives - 1 > 0 {
                            self.meteorController.rewindMeteors()
                            self.player.rewindPlayer()
                            meteor.hitMeteor()
                        } else {
                            self.player.destroyPlayer()
                        }
                        
                        self.flashBackground()
                        self.shakeBackground()
                        
                        self.player.updatePlayerLives()
                        self.statusBar.updateLives(self.player.lives)
                    }
                }
                
                
            } else if other.categoryBitMask == Contact.Star {
                // Player contacted a star
                if let star = other.node as? Star {
                    if !star.didContact {
                        self.player.pickedUpStar()
                        self.statusBar.updateStarsCollected(self.player.stars, score: self.player.score)
                        star.pickedUpStar()
                    }
                }
            }
        }
    }
    
    // MARK: - Game States
    private func switchToTutorial() {
        self.state = GameState.Tutorial
        
        self.player.disableMovement()
        
        self.gameNode.addChild(self.tapButton)
    }
    
    private func switchToRunning() {
        self.state = GameState.Running
        
        GameAudio.sharedInstance.playBackgroundMusic(Music.Game)
        
        self.player.enableMovement()
        
        self.player.updateTargetLocation(self.tapButton.position)
        
        self.meteorController.startSendingMeteors()
        
        self.starController.startSendingStars()
        
        self.tapButton.tapped()
        
        let getReady = GameTextures.sharedInstance.spriteWithName("GetReady")
        getReady.position = kScreenCenter
        self.gameNode.addChild(getReady)
        
        let action = SKAction.runBlock({
            getReady.runAction(SKAction.scaleTo(1.5, duration: 0.5), completion: {
                getReady.runAction(SKAction.scaleTo(1.75, duration: 0.5), completion: {
                    getReady.runAction(SKAction.fadeAlphaTo(0, duration: 0.5), completion: {
                        getReady.removeFromParent()
                    })
                })
            })
        })
        
        
        getReady.runAction(action)
    }
    
    private func switchToGameOver() {
        self.state = GameState.GameOver
        
        self.player.disableMovement()
        
        self.runAction(SKAction.runBlock({
            GameAudio.sharedInstance.stopBackgroundMusic()
            self.runAction(GameAudio.sharedInstance.soundLose)
        }))
        
        self.meteorController.stopSendingMeteors()
        self.meteorController.gameOver()
        
        self.starController.stopSendingStars()
        self.starController.gameOver()
        
        self.player.checkPlayerBestScore()
        
        self.runAction(SKAction.waitForDuration(3.0), completion: {
            let scene = GameOverScene(size: kViewSize, stars: self.player.stars, score: self.player.score)
            let transition = SKTransition.fadeWithColor(SKColor.blackColor(), duration: 0.25)
            self.view?.presentScene(scene, transition: transition)
        })
    }
    
    // MARK: - Scene Actions
    private func pauseButtonPressed() {
        self.statusBar.pauseButton.tappedPauseButton()
        
        if self.statusBar.pauseButton.tapped {
            self.gameNode.paused = true
            GameAudio.sharedInstance.pauseBackgroundMusic()
        } else {
            self.gameNode.paused = false
            GameAudio.sharedInstance.resumeBackgroundMusic()
        }
    }
    
    // MARK: - Action Functions
    func updateDistanceTickScore() {
        self.player.updatePlayerScore(1)
        self.statusBar.updateScore(self.player.score)
    }
    
    // MARK: - Animation Functions
    func flashBackground() {
        let colorFlash = SKAction.runBlock({
            self.backgroundColor = SKColorFromRGB(Colors.Flash)
            self.runAction(SKAction.waitForDuration(0.5), completion: {
                self.backgroundColor = SKColorFromRGB(Colors.Background)
            })
        })
        self.runAction(colorFlash)
    }
    
    func shakeBackground() {
        let shake = SKAction.screenShakeWithNode(self.gameNode, amount: CGPoint(x: 20, y: 15), oscillations: 10, duration: 0.75)
        self.runAction(shake)
    }
    
    // MARK: - Deinit
    deinit {
    }
}
