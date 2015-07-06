//
//  GameKitHelper.swift
//  Terranous
//
//  Created by Jeremy Novak on 7/6/15.
//  Copyright (c) 2015 Jeremy Novak. All rights reserved.
//

import GameKit

let GameKitHelperSharedInstance = GameKitHelper()

class GameKitHelper:NSObject {
    class var sharedInstance:GameKitHelper {
        return GameKitHelperSharedInstance
    }
    
    // MARK: - Private class properties
    private var enableGameCenter = false
    
    // MARK: - Public class properties
    var authenticationViewController = UIViewController()
    
    // MARK: - Init
    override init() {
        super.init()
    }
    
    func authenticatePlayer() {
        let localPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(viewController: UIViewController!, error: NSError!) -> Void in
            
            if viewController != nil {
                self.authenticationViewController(viewController)
            } else if localPlayer.authenticated {
                self.enableGameCenter = true
            }
        }
    }

    func authenticationViewController(authenticationViewController: UIViewController) {
        self.authenticationViewController = authenticationViewController
        NSNotificationCenter.defaultCenter().postNotificationName("GameCenterViewController", object: self)
    }
}