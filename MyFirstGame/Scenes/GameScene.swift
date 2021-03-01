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
    
    let cameraNode: SKCameraNode
    
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
        character = Character(name: .woodcutter) // <-- change the character here
        ground = Ground(size: size)
        
        treeSprite = Tree()
        treeSprite2 = Tree()
        
        attackButton = SpriteButton(imageNamed: "attackButton")
        padLeft = SpriteButton(imageNamed: "padLef")
        padRight = SpriteButton(imageNamed: "padRight")
        
        jumpButton = SpriteButton(imageNamed: "jumpButton")
        
        cameraNode = SKCameraNode()
        super.init(size: size)
        
        setup()
        buildNodeHierarchy()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    func setup() {
        
        physicsWorld.contactDelegate = self
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        scene?.backgroundColor = .myColor
        
        
        cameraNode.position.x = self.size.width / 2
        cameraNode.position.y = self.size.height / 2
        camera = cameraNode
        
        attackButton.position = CGPoint(x: cameraNode.frame.midX / 2 + 100, y: cameraNode.frame.midY / 2 - frame.midY)
        attackButton.button.size = CGSize(width: 40, height: 40)
        attackButton.zPosition = 10
        
        padLeft.position = CGPoint(x: cameraNode.frame.midX / 2 - frame.midX * 1.35, y: cameraNode.frame.midY / 2 - frame.midY - 60)
        padLeft.button.size = CGSize(width: 40, height: 40)
        padLeft.zPosition = 10
        
        padRight.position = CGPoint(x: padLeft.position.x + padLeft.button.size.width + 20, y: padLeft.position.y)
        padRight.button.size = CGSize(width: 40, height: 40)
        padRight.zPosition = 10
        
        jumpButton.position = CGPoint(x: attackButton.position.x, y:  attackButton.position.y - jumpButton.button.size.height - 20)
        jumpButton.button.size = CGSize(width: 40, height: 40)
        jumpButton.zPosition = 10
        
        setupButtons()
        
        // character
        loadCharacter(character)
        
        // background
        //        loadBackground(background: background)
        loadGround(ground)
        
        // elements
        loadTree(treeSprite)
        loadTree(treeSprite2)
    }
    
    func buildNodeHierarchy() {
        addChild(cameraNode)
        cameraNode.addChild(attackButton)
        cameraNode.addChild(jumpButton)
        cameraNode.addChild(padLeft)
        cameraNode.addChild(padRight)
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
        cameraNode.position.x = self.character.position.x
    }
   
}


// Collisions

// https://medium.com/@andreasorrentino/understanding-collisions-in-spritekit-swift-4-and-ios-11-ce62de4801cc

