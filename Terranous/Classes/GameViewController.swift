//
//  GameViewController.swift
//  Terranous
//
//  Created by Jeremy Novak on 7/5/15.
//  Copyright (c) 2015 Jeremy Novak. All rights reserved.
//

import UIKit
import SpriteKit
import iAd

class GameViewController: UIViewController, ADBannerViewDelegate {
    
    // MARK: - Private class properties
    private let textures = GameTextures.sharedInstance
    private let audio = GameAudio.sharedInstance
    private let fonts = GameFonts.sharedInstance
    private let settings = GameSettings.sharedInstance
    
    // MARK: - iAd
    #if FREE
    let bannerView = ADBannerView(adType: ADAdType.Banner)
    var bannerLoaded = false
    #endif
    
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
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showAuthenticationViewController", name: "GameCenterViewController", object: nil)
        
        GameKitHelper.sharedInstance.authenticatePlayer()
    }
    
    override func viewDidAppear(animated: Bool) {
        if GameSettings.sharedInstance.shouldRateApp() {
            self.showRateAppView()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        #if FREE
        bannerView.frame = CGRectMake(0, self.view.frame.size.height - bannerView.frame.size.height, self.view.frame.size.width, bannerView.frame.size.height)
        bannerView.autoresizingMask = UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleWidth
        bannerView.hidden = true
        bannerView.delegate = self
        self.view.addSubview(bannerView)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showAds", name: "AdBannerShow", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "hideAds", name: "AdBannerHide", object: nil)
        #endif
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
    
    // MARK: - iAd functions
#if FREE
    func showAds() {
        self.bannerView.hidden = false
    }
    
    func hideAds() {
        self.bannerView.hidden = true
    }
    
    func bannerViewWillLoadAd(banner: ADBannerView!) {
        self.bannerView.hidden = true
    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        self.bannerView.hidden = false
    }
    
    func bannerViewActionDidFinish(banner: ADBannerView!) {
        let skView = self.view as! SKView
        skView.scene?.paused = false
    
        GameAudio.sharedInstance.resumeBackgroundMusic()
    
        self.bannerView.hidden = false
    }
    
    func bannerViewActionShouldBegin(banner: ADBannerView!, willLeaveApplication willLeave: Bool) -> Bool {
        let skView = self.view as! SKView
        skView.scene?.paused = true
    
        GameAudio.sharedInstance.pauseBackgroundMusic()
    
        return true
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        self.bannerView.hidden = true
    }
#endif
    
    // MARK: - deinit
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
