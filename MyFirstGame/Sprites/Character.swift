//
//  Character.swift
//  MyFirstGame
//
//  Created by Vinicius Mesquita on 01/03/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation
import SpriteKit

protocol GameSprite {
    var atlas: SKTextureAtlas{ get set }
    var size: CGSize { get set }
   
}


class Character: SKSpriteNode, GameSprite {
    
    var atlas: SKTextureAtlas?
    var size: CGSize = CGSize(width: 100, height: 100)
    
    init() {
        super.init(texture: self.atlas, color: .black, size: self.size)
    }
    
    let woodCutter = SKSpriteNode(imageNamed: "woodCutter")
    
    
    var run = SKAction()
    
    var woodCutterFrame = [SKTexture]()
    var woodCutterFrameAttack = [SKTexture]()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadTextureAttack() {
        
        let textureAtlasAttack = SKTextureAtlas(named: "SpritesAttack")

        for index in 0..<textureAtlasAttack.textureNames.count {
            let textureName = "attack" + String(index)
            woodCutterFrameAttack.append(textureAtlasAttack.textureNamed(textureName))

        }
    }
    
    
    func loadTextureRun() {
        let textureAtlas = SKTextureAtlas(named: "SpritesWoodCutter")

        for index in 0..<textureAtlas.textureNames.count {
          let textureName = "tile00" + String(index)
          woodCutterFrame.append(textureAtlas.textureNamed(textureName))

        }
    }
}
