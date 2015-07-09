//
//  GameSettings.swift
//  Terranous
//
//  Created by Jeremy Novak on 7/5/15.
//  Copyright (c) 2015 Jeremy Novak. All rights reserved.
//

import Foundation

let GameSettingsSharedInstance = GameSettings()

class GameSettings {
    
    class var sharedInstance:GameSettings {
        return GameSettingsSharedInstance
    }
    
    // MARK: - Private class properties
    private let localDefaults = NSUserDefaults.standardUserDefaults()
    private let keyFirstRun = "FirstRun"
    private let keyBestStars = "BestStars"
    private let keyBestScore = "BestScore"
    private let keyLaunchedSessions = "LaunchedSessions"
    private let keyNeverRate = "NeverRate"
    
    private let promptSessions = 5
    private var launchedSessions = 0
    
    // MARK: - Public class properties
    
    // MARK: - Init
    init() {
        if self.localDefaults.objectForKey(keyFirstRun) == nil {
            self.firstLaunch()
        }
    }
    
    // MARK: - Private Functions
    private func firstLaunch() {
        self.localDefaults.setInteger(0, forKey: keyBestScore)
        self.localDefaults.setInteger(0, forKey: keyBestStars)
        self.localDefaults.setInteger(0, forKey: keyLaunchedSessions)
        self.localDefaults.setBool(false, forKey: keyFirstRun)
        self.localDefaults.setBool(false, forKey: keyNeverRate)
        self.localDefaults.synchronize()
    }
    
    // MARK: - Public saving functions
    func saveStarsCollected(collected: Int) {
        self.localDefaults.setInteger(collected, forKey: keyBestStars)
        self.localDefaults.synchronize()
    }
    
    func saveBestScore(score: Int) {
        self.localDefaults.setInteger(score, forKey: keyBestScore)
        self.localDefaults.synchronize()
    }
    
    func saveNeverRate() {
        self.localDefaults.setBool(true, forKey: keyNeverRate)
        self.localDefaults.synchronize()
    }
    
    // MARK: - Public retreiving functions
    func getBestStars() -> Int {
        return self.localDefaults.integerForKey(keyBestStars)
    }
    
    func getBestScore() -> Int {
        return self.localDefaults.integerForKey(keyBestScore)
    }
    
    // MARK: - Launch count
    func shouldRateApp() -> Bool {
        if self.localDefaults.boolForKey(keyNeverRate) == false || localDefaults.objectForKey(keyNeverRate) == nil {
            self.launchedSessions = self.localDefaults.integerForKey(keyLaunchedSessions)
            self.launchedSessions++
            self.localDefaults.setInteger(self.launchedSessions, forKey: keyLaunchedSessions)
            self.localDefaults.setBool(false, forKey: keyNeverRate)
            self.localDefaults.synchronize()
            
            return self.launchedSessions % self.promptSessions == 0 ? true : false
        } else {
            return false
        }
    }
}