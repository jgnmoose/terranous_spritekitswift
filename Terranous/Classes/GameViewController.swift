//
//  GameViewController.swift
//  Terranous
//
//  Created by Jeremy Novak on 7/5/15.
//  Copyright (c) 2015 Jeremy Novak. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    private let textures = GameTextures.sharedInstance
    private let audio = GameAudio.sharedInstance
    private let fonts = GameFonts.sharedInstance
    private let settings = GameSettings.sharedInstance
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if let skView = self.view as? SKView {
            if (skView.scene == nil) {
                if kDebug {
                    skView.showsFPS = true
                    skView.showsNodeCount = true
                    skView.showsDrawCount = true
                    skView.showsPhysics = true
                }
                
                skView.ignoresSiblingOrder = true
                
                let menuScene = MenuScene(size: kViewSize)
                let menuTransition = SKTransition.fadeWithColor(SKColor.blackColor(), duration: 0.25)
                
                skView.presentScene(menuScene, transition: menuTransition)
            }
        }
        
        if NetworkCheck.checkConnection() {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "showAuthenticationViewController", name: "GameCenterViewController", object: nil)
            
            GameKitHelper.sharedInstance.authenticatePlayer()
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // MARK: - GameKit Authentication View Controller
    func showAuthenticationViewController() {
        let gameKitHelper = GameKitHelper.sharedInstance
        self.presentViewController(gameKitHelper.authenticationViewController, animated: true, completion: nil)
    }
    
    // MARK: - Rate function
    private func showRateAppView() {
        var alertView = UIAlertController(title: "Rate Us", message: "Thanks for playing \(kAppName)!", preferredStyle: UIAlertControllerStyle.Alert)
        
        alertView.addAction(UIAlertAction(title: "Rate \(kAppName)", style: UIAlertActionStyle.Default, handler: { alertAction in
            UIApplication.sharedApplication().openURL(NSURL(string : kAppStoreURL)!)
            alertView.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        alertView.addAction(UIAlertAction(title: "No Thanks", style: UIAlertActionStyle.Default, handler: { alertAction in
            GameSettings.sharedInstance.saveNeverRate()
            alertView.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        alertView.addAction(UIAlertAction(title: "Maybe Later", style: UIAlertActionStyle.Default, handler: { alertAction in
            alertView.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alertView, animated: true, completion: nil)
    }
}
