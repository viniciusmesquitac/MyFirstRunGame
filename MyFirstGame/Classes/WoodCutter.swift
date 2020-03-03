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
        runMove = SKAction.move(to: changePosition(sprite: self), duration: 15.0)
        let runActions = [SKAction.repeatForever(runAnimate), SKAction.repeatForever(runMove)]
        let runGroupAnimate = SKAction.group(runActions)
        self.run(runGroupAnimate, withKey: Key.Run.rawValue)
    }
    
    func run() {
        SKAction.move(to: changePosition(sprite: self), duration: 15.0)
    }
    
    func jump(){
        jumpMove = SKAction.move(to: jump(sprite: self), duration: 0.1)
        self.run(jumpMove)
    }
    
    func attack() {
        attackAction = SKAction.animate(with: attackFrame, timePerFrame: 0.1)
        self.run(SKAction.repeatForever(attackAction), withKey: "Attack")
    }
    
    
    // auxilliary functions
    func changePosition(sprite: SKSpriteNode) -> CGPoint {
        let newPosition = CGPoint(x: sprite.position.x*15, y: sprite.position.y)
        return newPosition
    }

    func jump(sprite: SKSpriteNode) -> CGPoint {
        let newPosition = CGPoint(x: sprite.position.x*1.1, y: sprite.position.y * 1.2)
        return newPosition
    }

    func changePositionBack(sprite: SKSpriteNode, by: CGPoint) -> CGPoint {
        let newPosition = CGPoint(x: by.x * -15, y: by.y)
        return newPosition
    }

}
