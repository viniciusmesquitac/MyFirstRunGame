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


extension SKScene {
    
    func loadCharacter(_ player: SKSpriteNode) {
        
        let startPointX = frame.midX - frame.width/2 + player.size.width/2
        let startPointY = frame.midY - frame.height/2 + player.size.height + 100
        
        player.size = CGSize(width: 100.0, height: 100.0)
        player.zPosition = 1
        player.name = "cutter"
        player.position = CGPoint(x: startPointX, y: startPointY)
        let retaguleMask =  CGSize(width: player.size.width/3, height: player.size.height)
        player.physicsBody = SKPhysicsBody(rectangleOf: retaguleMask)
        player.physicsBody?.applyTorque(50)
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.contactTestBitMask = CategoryMask.woodcutter.rawValue | CategoryMask.tree.rawValue
        player.physicsBody?.categoryBitMask = CategoryMask.woodcutter.rawValue
        player.physicsBody?.collisionBitMask = CategoryMask.tree.rawValue
        addChild(player)
    }
    
    func animateBackground(background: SKSpriteNode) {
        
        let backgroundTexture = SKTexture(imageNamed: "background")
        
        let moveLeft = SKAction.moveBy(x: -backgroundTexture.size().width, y: 0, duration: 20)
        let moveReset = SKAction.moveBy(x: backgroundTexture.size().width, y: 0, duration: 0)
        let moveLoop = SKAction.sequence([moveLeft, moveReset])
        let moveForever = SKAction.repeatForever(moveLoop)
        
        background.run(moveForever)
        
        
    }
    
    func loadBackground(background: SKSpriteNode) {
        
        let backgroundTexture = SKTexture(imageNamed: "background")
        
        for i in 0...1 {
            let background = SKSpriteNode(texture: backgroundTexture)
            background.zPosition = -10
            background.anchorPoint = CGPoint.zero
            background.position = CGPoint(x: (backgroundTexture.size().width * CGFloat(i)) - CGFloat(1 * i), y: 0)
            addChild(background)
            
//            animateBackground(background: background)
        }
        
    }
    
    func loadGround() {
        
//        let groundTexture = SKTexture(imageNamed: "ground")
        
        let ground = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 50, height: 50))
        ground.size = CGSize(width: frame.width - 5, height: 50)
        ground.zPosition = 3
        ground.position = CGPoint(x: 2, y: frame.minY + 20)
        
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.affectedByGravity = false
        addChild(ground)
        
    }
    
    
    func loadTree(_ tree: SKSpriteNode) {
        
        tree.zPosition = 4
        tree.name = "tree"
        tree.position = CGPoint(x: CGFloat.random(in: frame.midX ..< frame.maxX), y: frame.midY)
        
        tree.physicsBody = SKPhysicsBody(rectangleOf: tree.size)
        tree.physicsBody?.categoryBitMask = CategoryMask.tree.rawValue
        tree.physicsBody?.contactTestBitMask = CategoryMask.woodcutter.rawValue
        addChild(tree)
    }
    
    
}
