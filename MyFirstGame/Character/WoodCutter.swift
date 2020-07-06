//
//  WoodCutter.swift
//  MyFirstGame
//
//  Created by Vinicius Mesquita on 02/03/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation
import SpriteKit

enum TextureAtlasCategory {
    case Attack, Run, Idle
}

enum Direction {
       case left
       case right
   }

enum PlayerActions: String {
    case run = "Run", attack = "Attack", idle = "Idle"
}

class WoodCutter: SKSpriteNode {
    
    // Player Proprieties
    var velocity: Double = 1.0
    var initialSize = CGSize(width: 100.0, height: 100.0)
    var myTexture: SKTexture? = SKTexture(imageNamed: "idle0")
    var movingTo: Direction?
    
    // Frames
    var runFrame = [SKTexture]()
    var attackFrame = [SKTexture]()
    var idleFrame = [SKTexture]()
    
    // Action animations
    var runAnimate = SKAction()
    var attackAction = SKAction()
    
    var jumpMove = SKAction()
    var runMove = SKAction()
    var idleAction = SKAction()
    
    init() {
        super.init(texture: myTexture, color: .clear, size: initialSize)
        
        let textureAtlasRun = SKTextureAtlas(named: "SpritesRunning")

        for index in 0..<textureAtlasRun.textureNames.count {
            let textureName = "run" + String(index)
            runFrame.append(textureAtlasRun.textureNamed(textureName))

        }

        let textureAtlasAttack = SKTextureAtlas(named: "SpritesAttack")

        for index in 0..<textureAtlasAttack.textureNames.count {
            let textureName = "attack" + String(index)
            attackFrame.append(textureAtlasAttack.textureNamed(textureName))

        }
        
        let textureAtlasIdle = SKTextureAtlas(named: "SpritesIdle")
        
        for index in 0..<textureAtlasIdle.textureNames.count {
            let textureName = "idle" + String(index)
            idleFrame.append(textureAtlasIdle.textureNamed(textureName))
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func createRunAnimate(direction: Direction) {
        runAnimate = SKAction.animate(with: runFrame, timePerFrame: 0.1)
        movingTo = direction
        runMove = SKAction.move(to: changePosition(sprite: self, direction: direction), duration: velocity)
       
        let runActions = [SKAction.repeatForever(runAnimate), SKAction.repeatForever(runMove)]
        let runGroupAnimate = SKAction.group(runActions)
        
        self.run(runGroupAnimate, withKey: PlayerActions.run.rawValue)
    }
    
    func attack() {
        attackAction = SKAction.animate(with: attackFrame, timePerFrame: 0.1)
        self.run(SKAction.repeatForever(attackAction), withKey: PlayerActions.attack.rawValue)
    }
    
    func  idle() {
        idleAction = SKAction.animate(with: idleFrame, timePerFrame: 0.5)
        self.run(SKAction.repeatForever(idleAction), withKey: PlayerActions.idle.rawValue)
    }
    
    func runMoveFunction() {
        guard let direction = movingTo else { return }
        runMove = SKAction.move(to: changePosition(sprite: self, direction: direction), duration: velocity)
        self.run(runMove)
    }
    
    func changePosition(sprite: SKSpriteNode, direction: Direction) -> CGPoint {
        
        switch direction {
        case .left:
            self.xScale = -1.0
            let newPosition = CGPoint(x: sprite.position.x - sprite.size.height, y: sprite.position.y)
            return newPosition
        case .right:
            self.xScale = 1.0
            let newPosition = CGPoint(x: sprite.position.x + sprite.size.height, y: sprite.position.y)
            return newPosition
        }
        
    }

    func jump() {
        // let newPosition = CGPoint(x: self.position.x*1.1, y: self.position.y * 1.2)
    }

}
