//
//  SKScene+Loadings.swift
//  MyFirstGame
//
//  Created by Vinicius Mesquita on 05/07/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import SpriteKit
import UIKit

// This is a mask used in our player sprite to interact with collisions
enum CategoryMask: UInt32 {
    case woodcutter = 0b01
    case tree = 0b10
    
}


extension GameScene {
    
    func loadCharacter(_ player: SKSpriteNode) {
        let startPointX = frame.midX - frame.width/2 + player.size.width/2
        let startPointY = frame.midY - frame.height/2 + player.size.height + 100
        player.size = CGSize(width: 100.0, height: 100.0)
        player.zPosition = 1
        player.name = "cutter"
        player.position = CGPoint(x: startPointX, y: startPointY)
        addChild(player)
    }
    
//    func animateBackground(background: SKSpriteNode) {
//
//        let backgroundTexture = SKTexture(imageNamed: "background")
//        
//        let moveLeft = SKAction.moveBy(x: -backgroundTexture.size().width, y: 0, duration: 20)
//        let moveReset = SKAction.moveBy(x: backgroundTexture.size().width, y: 0, duration: 0)
//        let moveLoop = SKAction.sequence([moveLeft, moveReset])
//        let moveForever = SKAction.repeatForever(moveLoop)
//        background.run(moveForever)
//
//    }
    
//    func loadBackground(background: SKSpriteNode) {
//        
//        let backgroundTexture = SKTexture(imageNamed: "background")
//        
//        for i in 0...1 {
//            let background = SKSpriteNode(texture: backgroundTexture)
//            background.zPosition = -10
//            background.anchorPoint = CGPoint.zero
//            background.position = CGPoint(x: (backgroundTexture.size().width * CGFloat(i)) - CGFloat(1 * i), y: 0)
//            addChild(background)
////            animateBackground(background: background)
//        }
//        
//    }
    
    func loadGround(_ ground: Ground) {
        ground.zPosition = 3
        ground.position.x = size.width / 2
        ground.position.y = ground.size.height / 2
        addChild(ground)
        
    }
    
    
    func loadTree(_ tree: SKSpriteNode) {
        tree.zPosition = 4
        tree.name = "tree"
        tree.position = CGPoint(x: CGFloat.random(in: frame.midX ..< frame.maxX), y: frame.midY)
        addChild(tree)
    }
    
    
}
