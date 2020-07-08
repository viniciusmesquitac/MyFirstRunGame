//
//  WoodCutter.swift
//  MyFirstGame
//
//  Created by Vinicius Mesquita on 02/03/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation
import SpriteKit

class WoodCutter: Character {
    
    // Player Proprieties
    var velocity: Double = 1.0
    var characterSize = CGSize(width: 100.0, height: 100.0)
    var characterTexture: SKTexture? = SKTexture(imageNamed: "idle0")
    var movingTo: Direction?
    var characterxScale: Double = 1.0
    
    // Frames
    var runFrame = [SKTexture]()
    var attackFrame = [SKTexture]()
    var idleFrame = [SKTexture]()
    var jumpFrame = [SKTexture]()
    
    // Action animations
    var runAnimate = SKAction()
    var attackAction = SKAction()
    
    var jumpMove = SKAction()
    var runMove = SKAction()
    var idleAction = SKAction()
    
    
    init() {
        
        super.init(texture: characterTexture, color: .clear, size: characterSize)
        
        runFrame = loadAtlas(atlasName: "SpritesRun", textureName: "run")
        
        attackFrame = loadAtlas(atlasName: "SpritesAttack", textureName: "attack")
        
        idleFrame = loadAtlas(atlasName: "SpritesIdle", textureName: "idle")
        
        jumpFrame = loadAtlas(atlasName: "SpritesJump", textureName: "jump")
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadAtlas(atlasName: String, textureName: String) -> [SKTexture] {
        
        var actionFrame = [SKTexture]()
        let textureAtlas = SKTextureAtlas(named: atlasName)
        
        for index in 0..<textureAtlas.textureNames.count {
            let textureName = textureName + String(index)
            actionFrame.append(textureAtlas.textureNamed(textureName))
        }
        
        return actionFrame
        
    }
    
    // MARK: - Init
    func setup() {
        let retaguleMask =  CGSize(width: size.width/3, height: size.height)
        physicsBody = SKPhysicsBody(rectangleOf: retaguleMask)
        physicsBody?.allowsRotation = false
        physicsBody?.applyTorque(50.0)
        physicsBody?.contactTestBitMask = CategoryMask.woodcutter.rawValue | CategoryMask.tree.rawValue
        physicsBody?.categoryBitMask = CategoryMask.woodcutter.rawValue
        physicsBody?.collisionBitMask = CategoryMask.tree.rawValue
    }
    
}

extension WoodCutter {
    
    func run(direction: Direction) {
        runAnimate = SKAction.animate(with: runFrame, timePerFrame: 0.1)
        movingTo = direction
        runMove = SKAction.move(to: changePosition(sprite: self, direction: direction), duration: velocity)
        
        let runActions = [SKAction.repeatForever(runAnimate), SKAction.repeatForever(runMove)]
        let runGroupAnimate = SKAction.group(runActions)
        
        self.run(runGroupAnimate, withKey: PlayerActions.run.rawValue)
    }
    
    
    func move() {
        guard let direction = movingTo else { return }
        runMove = SKAction.move(to: changePosition(sprite: self, direction: direction), duration: velocity)
        self.run(runMove)
    }
    
    func attack(repeatForever: Bool = true) {
        attackAction = SKAction.animate(with: attackFrame, timePerFrame: 0.1)
        
        if repeatForever {
            self.run(SKAction.repeatForever(attackAction), withKey: PlayerActions.attack.rawValue)
        } else {
            self.run(attackAction, withKey: PlayerActions.attack.rawValue)
        }
    }
    
    func idle() {
        idleAction = SKAction.animate(with: idleFrame, timePerFrame: 0.5)
        self.run(SKAction.repeatForever(idleAction), withKey: PlayerActions.idle.rawValue)
    }
    
    func jump() {
//        let newPosition = CGPoint(x: self.position.x * 1.1, y: self.position.y * 1.2)
        idleAction = SKAction.animate(with: idleFrame, timePerFrame: 0.5)
        self.run(SKAction.repeatForever(idleAction), withKey: PlayerActions.jump.rawValue)
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
  
}
