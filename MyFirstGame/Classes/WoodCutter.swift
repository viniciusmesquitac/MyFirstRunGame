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
    case Attack, Run
}

class WoodCutter: SKSpriteNode {
    
    var velocity: Double = 0.4
    var initialSize = CGSize(width: 100.0, height: 100.0)
    var myTexture: SKTexture? = SKTexture(imageNamed: "tile001")
    
    var runFrame = [SKTexture]()
    var attackFrame = [SKTexture]()
    
    var runAnimate = SKAction()
    var runMove = SKAction()
    var attackAction = SKAction()
       
    var jumpMove = SKAction()
    
    init() {
        super.init(texture: myTexture, color: .clear, size: initialSize)
        
        let textureAtlasRun = SKTextureAtlas(named: "SpritesWoodCutter")

        for index in 0..<textureAtlasRun.textureNames.count {
            let textureName = "tile00" + String(index)
            runFrame.append(textureAtlasRun.textureNamed(textureName))

        }

        let textureAtlasAttack = SKTextureAtlas(named: "SpritesAttack")

        for index in 0..<textureAtlasAttack.textureNames.count {
            let textureName = "attack" + String(index)
            attackFrame.append(textureAtlasAttack.textureNamed(textureName))

        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func createRunAnimate() {
        runAnimate = SKAction.animate(with: runFrame, timePerFrame: 0.1)
        runMove = SKAction.move(to: changePosition(sprite: self), duration: velocity)
       
        let runActions = [SKAction.repeatForever(runAnimate), SKAction.repeatForever(runMove)]
        let runGroupAnimate = SKAction.group(runActions)
        
        self.run(runGroupAnimate, withKey: Key.Run.rawValue)
    }
    
    func attack() {
        attackAction = SKAction.animate(with: attackFrame, timePerFrame: 0.1)
        self.run(SKAction.repeatForever(attackAction), withKey: "Attack")
    }
    
    func runMoveFunction() {
        runMove = SKAction.move(to: changePosition(sprite: self), duration: velocity)
        self.run(runMove)
    }
    
    func changePosition(sprite: SKSpriteNode) -> CGPoint {
        let newPosition = CGPoint(x: sprite.position.x + sprite.size.height, y: sprite.position.y)
        return newPosition
    }

    func jump() {
        // let newPosition = CGPoint(x: self.position.x*1.1, y: self.position.y * 1.2)
    }

}
