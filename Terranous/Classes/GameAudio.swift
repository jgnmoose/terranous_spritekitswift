//
//  GameAudio.swift
//  Terranous
//
//  Created by Jeremy Novak on 7/5/15.
//  Copyright (c) 2015 Jeremy Novak. All rights reserved.
//

import AVFoundation
import SpriteKit

internal class Music {
    class var Intro:String          { return "IntroMusic.mp3" }
    class var Game:String           { return "GameMusic.mp3" }
    class var Menu:String           { return "MenuMusic.mp3" }
}

private class SoundEffects {
    class var Pop:String            { return "Pop.caf" }
    class var Score:String          { return "Score.caf" }
    class var Bonus:String          { return "BonusPoints.caf" }
    class var BonusMax:String       { return "MaxBonus.caf" }
    class var Lose:String           { return "Lose.caf" }
    class var Explode:String        { return "Explode.caf" }
    class var Destroyed:String      { return "Destroyed.caf" }
    class var EngineStart:String    { return "EngineStart.caf" }
}

let GameAudioSharedInstance = GameAudio()

class GameAudio {
    
    class var sharedInstance:GameAudio {
        return GameAudioSharedInstance
    }
    
    // MARK: - Private class properties
    private var musicPlayer = AVAudioPlayer()
    
    // MARK: - Public class properties
    internal let soundEngineStart = SKAction.playSoundFileNamed(SoundEffects.EngineStart, waitForCompletion: false)
    internal let soundScore = SKAction.playSoundFileNamed(SoundEffects.Score, waitForCompletion: false)
    internal let soundBonus = SKAction.playSoundFileNamed(SoundEffects.Bonus, waitForCompletion: false)
    internal let soundBonusMax = SKAction.playSoundFileNamed(SoundEffects.BonusMax, waitForCompletion: false)
    internal let soundLose = SKAction.playSoundFileNamed(SoundEffects.Lose, waitForCompletion: false)
    internal let soundExplode = SKAction.playSoundFileNamed(SoundEffects.Explode, waitForCompletion: false)
    internal let soundDestroyed = SKAction.playSoundFileNamed(SoundEffects.Destroyed, waitForCompletion: false)
    internal let soundPop = SKAction.playSoundFileNamed(SoundEffects.Pop, waitForCompletion: false)
    
    // MARK: - Init
    init () {
    }
    
    // MARK: - Music Player
    func playBackgroundMusic(filename: String) {
        let music = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(filename, ofType: nil)!)
        var playerError:NSError?
        
        self.musicPlayer = AVAudioPlayer(contentsOfURL: music, error: &playerError)
        self.musicPlayer.numberOfLoops = -1
        self.musicPlayer.volume = 0.25
        self.musicPlayer.prepareToPlay()
        self.musicPlayer.play()
    }
    
    
    func stopBackgroundMusic () {
        if self.musicPlayer.playing {
            self.musicPlayer.stop()
        }
    }
    
    func pauseBackgroundMusic () {
        if self.musicPlayer.playing {
            self.musicPlayer.pause()
        }
    }
    
    func resumeBackgroundMusic () {
        if !self.musicPlayer.playing {
            self.musicPlayer.play()
        }
    }
}
