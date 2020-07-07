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
    
    // character
    var character = WoodCutter()
    
    // enviroment
    let background = SKSpriteNode(imageNamed: "background")
    let ground = SKSpriteNode(color: UIColor.green, size: CGSize(width: 50, height: 50))
    
    // objects
    let treeSprite = Tree()
    let treeSprite2 = Tree()
    
    // interface
    var attackButton = SpriteButton(imageNamed: "attackButton")
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        scene?.backgroundColor = .myColor
        
        setupNodes()
        setupButton()
        addNode()
        
    
        
    }
    
    func addNode() {
        addChild(attackButton)
    }
    
    func setupNodes() {
//        padLeft.size = CGSize(width: 50, height: 50)
        attackButton.position = CGPoint(x: size.width/2, y: size.height/2)
        
        // character
        loadCharacter(character)
        
        // background
        loadBackground(background: background)
        loadGround()
        
        // elements
        loadTree(treeSprite)
        loadTree(treeSprite2)
    }
    
    
    func setupButton() {
        
        attackButton.setAction {
            
            self.character.removeAllActions()
            self.character.idle()
            self.character.attack(repeatForever: false)
            
            if self.character.frame.intersects(self.treeSprite.frame) {
                print("atacou!!")
                
                self.treeSprite.life -= 1
                
                if self.treeSprite.life == 0 {
                    self.treeSprite.removeFromParent()
                }
            }
            
            if self.character.frame.intersects(self.treeSprite2.frame) {
                
                self.treeSprite2.life -= 1
                
                if self.treeSprite2.life == 0 {
                    self.treeSprite2.removeFromParent()
                }
            }
        }
        
        
        
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
        if let _ = character.action(forKey: PlayerActions.run.rawValue) {
            character.removeAllActions()
            character.idle()
        } else {
            if !character.frame.intersects(self.treeSprite.frame) {
                character.run(direction: direction)
            } else {
                character.attack()
            }
        }
        
        // if not attacking, running.
        if let _ = character.action(forKey: PlayerActions.attack.rawValue) {
            character.removeAllActions()
            character.run(direction: direction)
        } else {
            
            // if attaching the limits of screen, the player will be send to the start!
            if character.position.x > frame.maxX {
                let startPointX = frame.midX - frame.width/2 + character.size.width/2
                let startPointY = frame.midY - frame.height/2 + character.size.height + 100
                // goodbye player :>
                character.position = CGPoint(x: startPointX, y: startPointY)
            }
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        // Handle collision in scene
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collision == CategoryMask.woodcutter.rawValue | CategoryMask.tree.rawValue {
            self.character.removeAllActions()
            self.character.idle()
//            let tree = contact.bodyB.node as? Tree
//                       tree?.life -= 1
//
//                       if tree?.life == 0 {
//                           contact.bodyB.node?.removeFromParent()
//                       }

            
        }
    }
    
    
    override func didEvaluateActions() {
        if let _ = character.action(forKey: PlayerActions.run.rawValue) {
            character.move()
        } else {
            // the player is not running
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
   
}


// Collisions

// https://medium.com/@andreasorrentino/understanding-collisions-in-spritekit-swift-4-and-ios-11-ce62de4801cc

