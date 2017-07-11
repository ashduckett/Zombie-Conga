//
//  GameScene.swift
//  ZombieConga
//
//  Created by Ash Duckett on 11/07/2017.
//  Copyright © 2017 Ash Duckett. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let zombie = SKSpriteNode(imageNamed: "zombie1")
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor.black
        
        let background = SKSpriteNode(imageNamed: "background1")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.zPosition = -1
        
        zombie.position = CGPoint(x: 400, y: 400)
        zombie.xScale = 2
        zombie.yScale = 2
        
        addChild(background)
        addChild(zombie)
    }
    
    
}
