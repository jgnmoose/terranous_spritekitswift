//
//  Title.swift
//  Terranous
//
//  Created by Jeremy Novak on 7/5/15.
//  Copyright (c) 2015 Jeremy Novak. All rights reserved.
//

import SpriteKit

class Title:SKSpriteNode {
    
    // MARK: - Private class properties
    
    // MARK: - Public class properties
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let texture = SKTexture(imageNamed: SpriteName.Title)
        self.init(texture: texture, color: SKColor.whiteColor(), size: texture.size())
        
        self.setupTitle()
    }
    
    // MARK: - Setup Functions
    private func setupTitle() {
        self.position = CGPoint(x: kScreenCenterHorizontal, y: kViewSize.height * 1.25)
        
        self.zPosition = GameLayer.Interface
    }
    
    // MARK: - Action Functions
    func animateTitle() {
        let titleFirstPosition = CGPoint(x: kScreenCenterHorizontal, y: kViewSize.height * 0.525)
        let titleSecondPosition = CGPoint(x: kScreenCenterHorizontal, y: kViewSize.height * 0.6)
        
        let titleAnimation = SKAction.runBlock({
            self.runAction(SKAction.moveTo(titleFirstPosition, duration: 0.5), completion: {
                self.runAction(SKAction.moveTo(titleSecondPosition, duration: 0.5))
            })
        })
        
        self.runAction(titleAnimation)
    }    
}