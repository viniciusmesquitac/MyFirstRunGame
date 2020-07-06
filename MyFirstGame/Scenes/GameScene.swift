//
//  GameScene.swift
//  MyFirstGame
//
//  Created by Vinicius Mesquita on 22/02/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player = WoodCutter()
    let bgSprite = SKSpriteNode(imageNamed: "background")
    
    let groundSprite = SKSpriteNode(color: UIColor.green, size: CGSize(width: 50, height: 50))
    let treeSprite = Tree()
    let treeSprite2 = Tree()
    
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        scene?.backgroundColor = .myColor
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        
        // character
        loadCharacter(player)
        
        // background
        loadBackground(background: bgSprite)
        loadGround()
        
        // elements
        loadTree(treeSprite)
        loadTree(treeSprite2)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
   
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if(location.x < self.size.width / 2) {
                handlePlayerActions(direction: .left)
            }
            
            if(location.x > self.size.width / 2) {
                handlePlayerActions(direction: .right)
            }
            
        }
        
        
        
    }
    
    func handlePlayerActions(direction: Direction) {
        
        // if not running, attacking.
        if let _ = player.action(forKey: PlayerActions.run.rawValue) {
            player.removeAllActions()
            player.idle()
        } else {
            if !player.frame.intersects(self.treeSprite.frame) {
                player.createRunAnimate(direction: direction)
            } else {
                player.attack()
            }
        }
        
        // if not attacking, running.
        if let _ = player.action(forKey: PlayerActions.attack.rawValue) {
            player.removeAllActions()
            player.createRunAnimate(direction: direction)
        } else {
            
            // if attaching the limits of screen, the player will be send to the start!
            if player.position.x > frame.maxX {
                let startPointX = frame.midX - frame.width/2 + player.size.width/2
                let startPointY = frame.midY - frame.height/2 + player.size.height + 100
                // goodbye player :>
                player.position = CGPoint(x: startPointX, y: startPointY)
            }
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        // Handle collision in scene
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collision == CategoryMask.woodcutter.rawValue | CategoryMask.tree.rawValue {
            print("the sprite \(contact.bodyA.node?.name ?? "bodyA") colide with the \(contact.bodyB.node?.name ?? "bodyB")" )
            
            self.player.removeAllActions()
            player.attack()
            
            let tree = contact.bodyB.node as? Tree
            tree?.life -= 1
            
            if tree?.life == 0 {
                contact.bodyB.node?.removeFromParent()
            }

            
        }
    }
    
    
    override func didEvaluateActions() {
        if let _ = player.action(forKey: PlayerActions.run.rawValue) {
            player.runMoveFunction()
        } else {
            // the player is not running
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
   
}


// Collisions

// https://medium.com/@andreasorrentino/understanding-collisions-in-spritekit-swift-4-and-ios-11-ce62de4801cc

