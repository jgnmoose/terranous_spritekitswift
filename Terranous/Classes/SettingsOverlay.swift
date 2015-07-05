//
//  SettingsOverlay.swift
//  Terranous
//
//  Created by Jeremy Novak on 7/5/15.
//  Copyright (c) 2015 Jeremy Novak. All rights reserved.
//

import SpriteKit

class SettingsOverlay:SKNode {
    
    // MARK: - Private class properties
    //private var musicEnabledLabel = BMGlyphLabel()
    //private var musicVolumeLabel = BMGlyphLabel()
    private var musicFile = String()
    
    // MARK: - Public class properties
    internal var doneButton = SKSpriteNode()
    internal var musicButton = SKSpriteNode()
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        
        self.userInteractionEnabled = true
        
        self.zPosition = GameLayer.Settings
        
        self.setupSettingsBackground()
        self.setupShapeNode()
        self.setupSettingsLabel()
        self.setupDoneButton()
        self.setupMusicToggle()
        self.setupMusicVolume()
    }
    
    internal override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch:UITouch = touches.first as! UITouch
        let touchLocation = touch.locationInNode(self)
        
        if self.doneButton.containsPoint(touchLocation) {
            self.tappedDoneButton()
        }
        
        if self.musicButton.containsPoint(touchLocation) {
            self.tappedMusicButton()
        }
    }
    
    // MARK: - Setup Functions
    private func setupSettingsBackground() {
        let backgroundSize = CGSizeMake(kViewSize.width, kViewSize.height)
        let background = SKSpriteNode(color: SKColorFromRGB(Colors.Background), size: backgroundSize)
        
        background.anchorPoint = CGPointZero
        background.position = CGPointZero
        
        self.addChild(background)
    }
    
    private func setupShapeNode() {
        let shape = CGRectMake(0, 0, kViewSize.width * 0.9, kViewSize.height * 0.5)
        let settingsShapeNode = SKShapeNode(rect: shape, cornerRadius: 5)
        
        settingsShapeNode.fillColor = SKColorFromRGB(Colors.Background)
        settingsShapeNode.strokeColor = SKColor.whiteColor()
        
        settingsShapeNode.position = CGPoint(x: kViewSize.width * 0.05, y: kViewSize.height * 0.25)
        
        if kDeviceTablet {
            settingsShapeNode.lineWidth = 6.0
        } else {
            settingsShapeNode.lineWidth = 3.0
        }
        
        settingsShapeNode.alpha = 1.0
        
        self.addChild(settingsShapeNode)
    }
    
    private func setupSettingsLabel() {
//        let label = GameFonts.sharedInstance.createTextLabel("Terranous Settings")
//        label.position = CGPoint(x: kScreenCenterHorizontal, y: kViewSize.height * 0.8)
//        
//        self.addChild(label)
    }
    
    private func setupMusicToggle() {
//        if GameSettings.sharedInstance.getMusicEnabled() {
//            self.musicEnabledLabel = GameFonts.sharedInstance.createTextLabel("Music On")
//            self.musicButton = GameTextures.sharedInstance.spriteWithName(SpriteName.ButtonMusicOn)
//        } else {
//            self.musicEnabledLabel = GameFonts.sharedInstance.createTextLabel("Music Off")
//            self.musicButton = GameTextures.sharedInstance.spriteWithName(SpriteName.ButtonMusicOff)
//        }
        
//        self.musicEnabledLabel.horizontalAlignment = BMGlyphHorizontalAlignmentLeft
//        self.musicEnabledLabel.verticalAlignment = BMGlyphVerticalAlignmentMiddle
//        self.musicEnabledLabel.position = CGPoint(x: kViewSize.width * 0.15, y: kViewSize.height * 0.65)
//        
//        self.musicButton.position = CGPoint(x: kViewSize.width * 0.85, y: kViewSize.height * 0.65)
//        
//        self.addChild(self.musicEnabledLabel)
//        self.addChild(self.musicButton)
    }
    
    private func setupMusicVolume() {
//        let musicVolumeLabel = GameFonts.sharedInstance.createTextLabel("Music Volume")
//        
//        musicVolumeLabel.horizontalAlignment = BMGlyphHorizontalAlignmentLeft
//        musicVolumeLabel.position = CGPoint(x: kViewSize.width * 0.15, y: kScreenCenterVertical)
//        
//        self.musicVolumeLabel = GameFonts.sharedInstance.createTextLabel(NSString(format: "%.0f%%", GameSettings.sharedInstance.getMusicVolume()) as String)
//        
//        self.musicVolumeLabel.horizontalAlignment = BMGlyphHorizontalAlignmentLeft
//        self.musicVolumeLabel.position = CGPoint(x: kViewSize.width * 0.7, y: kScreenCenterVertical)
//        
//        self.addChild(musicVolumeLabel)
//        self.addChild(self.musicVolumeLabel)
    }
    
    private func setupDoneButton() {
        self.doneButton = GameTextures.sharedInstance.spriteWithName(SpriteName.ButtonRetry)
        self.doneButton.position = CGPoint(x: kScreenCenterHorizontal, y: kViewSize.height * 0.3)
        
        self.addChild(self.doneButton)
    }
    
    // MARK: - Action Functions
    func tappedDoneButton() {
        self.runAction(GameAudio.sharedInstance.soundPop, completion: {
            self.removeFromParent()
        })
    }
    
    func tappedMusicButton() {
        var enabled = !GameSettings.sharedInstance.getMusicEnabled()
        GameSettings.sharedInstance.saveMusicEnabled(enabled)
        
        let onTexture = GameTextures.sharedInstance.textureWithName(SpriteName.ButtonMusicOn)
        let offTexture = GameTextures.sharedInstance.textureWithName(SpriteName.ButtonMusicOff)
        
        let texture = enabled ? onTexture : offTexture
        
        self.musicButton.texture = texture
        
        if enabled {
            //self.musicEnabledLabel.text = "Music On"
            GameAudio.sharedInstance.playBackgroundMusic(Music.Menu)
        } else {
            //self.musicEnabledLabel.text = "Music Off"
            GameAudio.sharedInstance.stopBackgroundMusic()
        }
    }
}

