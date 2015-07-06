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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let skView = self.view as? SKView {
            if kDebug {
                skView.showsDrawCount = true;
                skView.showsFPS = true;
                skView.showsNodeCount = true;
                skView.showsPhysics = true;
            }
            
            skView.ignoresSiblingOrder = true
            
            let menuScene = MenuScene(size: kViewSize)
            menuScene.scaleMode = SKSceneScaleMode.AspectFill
            
            skView.presentScene(menuScene)
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
}
