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
    
    let character: Character
    let ground: Ground
    
    // objects
    let treeSprite: Tree
    let treeSprite2: Tree
    
    // interface
    let attackButton: SpriteButton
    let padLeft: SpriteButton
    let padRight: SpriteButton
    let jumpButton: SpriteButton
    
    
    // MARK: - Init
    override init(size: CGSize) {
        character = WoodCutter() // <-- change the character here
        ground = Ground(size: size)
        
        treeSprite = Tree()
        treeSprite2 = Tree()
        
        attackButton = SpriteButton(imageNamed: "attackButton")
        padLeft = SpriteButton(imageNamed: "padLef")
        padRight = SpriteButton(imageNamed: "padRight")
        
        jumpButton = SpriteButton(imageNamed: "jumpButton")
        
        super.init(size: size)
        
        setup()
        setupButtons()
        addNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    func setup() {
        
        physicsWorld.contactDelegate = self
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        scene?.backgroundColor = .myColor
        
        attackButton.position = CGPoint(x: frame.midX + size.width/3, y: frame.midY - 100)
        attackButton.button.size = CGSize(width: 40, height: 40)
        attackButton.zPosition = 10
        
        padLeft.position = CGPoint(x: frame.midX - size.width/4 - 150, y: frame.midY - 150)
        padLeft.button.size = CGSize(width: 40, height: 40)
        padLeft.zPosition = 10
        
        padRight.position = CGPoint(x: padLeft.position.x + padLeft.button.size.width + 20, y: padLeft.position.y)
        padRight.button.size = CGSize(width: 40, height: 40)
        padRight.zPosition = 10
        
        jumpButton.position = CGPoint(x: attackButton.position.x, y:  attackButton.position.y - jumpButton.button.size.height - 20)
        jumpButton.button.size = CGSize(width: 40, height: 40)
        jumpButton.zPosition = 10
        
        // character
        loadCharacter(character)
        
        // background
        //        loadBackground(background: background)
        loadGround(ground)
        
        // elements
        loadTree(treeSprite)
        loadTree(treeSprite2)
    }
    
    func addNode() {
        addChild(attackButton)
        addChild(jumpButton)
        addChild(padLeft)
        addChild(padRight)
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
                character.attack(repeatForever: false)
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

