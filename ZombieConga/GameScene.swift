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
    var lastUpdateTime: TimeInterval = 0
    var dt: TimeInterval = 0
    let zombieMovePointsPerSec: CGFloat = 480.0
    var velocity = CGPoint.zero
    let playableRect: CGRect
    let zombieRotateRadiansPerSec: CGFloat = 4.0 * CGFloat.pi
    
    // Store the last place the player touched the scene
    var lastTouchLocation: CGPoint?
    
    override init(size: CGSize) {
        let maxAspectRatio: CGFloat = 16.0 / 9
        let playableHeight = size.width / maxAspectRatio
        let playableMargin = (size.height - playableHeight) / 2.0
        playableRect = CGRect(x: 0, y: playableMargin, width: size.width, height: playableHeight)
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor.black
        
        let background = SKSpriteNode(imageNamed: "background1")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.zPosition = -1
        
        zombie.position = CGPoint(x: 400, y: 400)
        
        addChild(background)
        addChild(zombie)
        debugDrawPlayableArea()
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        } else {
            dt = 0
        }
        
        lastUpdateTime = currentTime
      
        // Here we want to get the distance between the last touch location and the zombie. This is the first step.
        
        // lastTouchLocation is essentially a vector from the origin to the touch
        // zombie.position gives us a vector from the origin to the zombie
        
        // Find the offset vector
        
        if let lastTouchLocation = lastTouchLocation {
            let offsetVector = lastTouchLocation - zombie.position
            let distance = offsetVector.length()
            print("The distance is: \(distance)")
        
            // How much will the zombie move this frame?
            let aboutToMoveDistance = zombieMovePointsPerSec * CGFloat(dt)
            
            if distance <= aboutToMoveDistance {
                zombie.position = lastTouchLocation
                velocity = CGPoint.zero
            } else {
                move(sprite: zombie, velocity: velocity)
                boundsCheckZombie()
                
                // How do we get a current angle vs. a target angle?
                
                
                
                
                
                //let amountToRotate = zombieRotateRadiansPerSec * CGFloat(dt)
                
                
                
                rotate(sprite: zombie, direction: velocity, rotateRadiansPerSec: zombieRotateRadiansPerSec)
                
                // Direction is a CGPoint
                // Let's get the shortest angle between direction and the target
                
                
                
               // let shortest = shortestAngleBetween(angle1: zombie.zRotation, angle2: velocity.angle)
                
               // let amountToRotate = zombieRotateRadiansPerSec * CGFloat(dt)
                
                
                
                //var valueToUse = abs(shortest) < amountToRotate ? abs(shortest) : amountToRotate
                
                //valueToUse = valueToUse * valueToUse.sign()
                
                //rotate(sprite: zombie, direction: velocity, rotateRadiansPerSec: valueToUse)
            
            
                // Currently, rotation works by taking the angle of the velocity.
            
            
            }
        
        }
        
        
        
        
        
        
    }
    
    func move(sprite: SKSpriteNode, velocity: CGPoint) {
        let amountToMove = velocity * CGFloat(dt)
        sprite.position += amountToMove
    }
    
    func moveZombueToward(location: CGPoint) {
        let offset = location - zombie.position
        let direction = offset.normalized()
        velocity = direction * zombieMovePointsPerSec
    }
    
    func sceneTouched(touchLocation: CGPoint) {
        lastTouchLocation = touchLocation
        print("Obtained touch location: \(lastTouchLocation!)")
        moveZombueToward(location: touchLocation)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        sceneTouched(touchLocation: touchLocation)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let touchLocation = touch.location(in: self)
        sceneTouched(touchLocation: touchLocation)
    }
    
    func boundsCheckZombie() {
        let bottomLeft = CGPoint(x: 0, y: playableRect.minY)
        let topRight = CGPoint(x: size.width, y: playableRect.maxY)
        
        
        if zombie.position.x <= bottomLeft.x {
            zombie.position.x = bottomLeft.x
            velocity.x = -velocity.x
        }
        
        if zombie.position.x >= topRight.x {
            zombie.position.x = topRight.x
            velocity.x = -velocity.x
        }
        
        if zombie.position.y <= bottomLeft.y {
            zombie.position.y = bottomLeft.y
            velocity.y = -velocity.y
        }
        
        if zombie.position.y >= topRight.y {
            zombie.position.y = topRight.y
            velocity.y = -velocity.y
        }
    }
    
    func debugDrawPlayableArea() {
        let shape = SKShapeNode()
        let path = CGMutablePath()
        path.addRect(playableRect)
        shape.path = path
        shape.strokeColor = SKColor.red
        shape.lineWidth = 4.0
        addChild(shape)
    }
    
    func rotate(sprite: SKSpriteNode, direction: CGPoint, rotateRadiansPerSec: CGFloat) {
        // What goes in here?
        
        let shortest = shortestAngleBetween(angle1: sprite.zRotation, angle2: velocity.angle)
        let amountToRotate = min(rotateRadiansPerSec * CGFloat(dt), abs(shortest))
        
        sprite.zRotation += shortest.sign() * amountToRotate
        //sprite.zRotation = direction.angle //* rotateRadiansPerSec
        
    }
    
    
}
