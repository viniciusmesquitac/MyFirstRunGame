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
    
    let woodCutterCategory: UInt32 = 0x1 << 0
    let treeSpriteCategory: UInt32 = 0x1 << 1
    
    var player = WoodCutter()
    let bgSprite = SKSpriteNode(imageNamed: "background")
    let groundSprite = SKSpriteNode(color: UIColor.green, size: CGSize(width: 50, height: 50))
    
    let treeSprite = SKSpriteNode(color: UIColor.green, size: CGSize(width: 30, height: 100))
    let treeSprite2 = SKSpriteNode(color: UIColor.green, size: CGSize(width: 30, height: 100))
    
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        scene?.backgroundColor = .myColor
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        
        // character
        loadCharacter(player)
        
        // background
        loadBackground()
        loadGround()
        
        // elements
        loadTree(tree: treeSprite)
        loadTree(tree: treeSprite2)
     
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        // let backgroundMove = SKAction.move(to: changePositionBack(sprite: bgSprite, by: bgSprite.position), duration: 100.0)
        

        if let _ = player.action(forKey: "Run") {
            player.removeAllActions()
        } else {
            if !player.frame.intersects(self.treeSprite.frame) {
                player.createRunAnimate()
            } else {
                if self.childNode(withName: "tree") == nil {
                    player.createRunAnimate()
                }
            }
        }
        
        if let _ = player.action(forKey: "Attack") {
            player.removeAllActions()
            player.createRunAnimate()
        } else {
            print("stop / run cutter")
            // player.jump()
            
            if player.position.x > frame.maxX {
                let startPointX = frame.midX - frame.width/2 + player.size.width/2
                let startPointY = frame.midY - frame.height/2 + player.size.height + 100
                player.position = CGPoint(x: startPointX, y: startPointY)
            }
        }
        
        
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collision == woodCutterCategory | treeSpriteCategory {
            print("the sprite \(contact.bodyA.node?.name ?? "bodyA") colide with the \(contact.bodyB.node?.name ?? "bodyB")" )
            
            self.player.removeAllActions()
            player.attack()
            contact.bodyB.node?.removeFromParent()
            
        }
    }
    
    
    override func didEvaluateActions() {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    
    func loadBackground() {
        
        let backgroundTexture = SKTexture(imageNamed: "background")
        
        for i in 0...1 {
            let background = SKSpriteNode(texture: backgroundTexture)
            background.zPosition = -10
            background.anchorPoint = CGPoint.zero
            background.size = CGSize(width: frame.size.width, height: frame.size.height)
            background.position = CGPoint(x: (backgroundTexture.size().width * CGFloat(i)) - CGFloat(1 * i), y: 0)
            addChild(background)
        }
        
    }
    
    func loadGround() {
        
        let groundTexture = SKTexture(imageNamed: "ground")
    
        let ground = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 50, height: 50))
        ground.size = CGSize(width: frame.width - 5, height: 50)
        ground.zPosition = 3
        ground.position = CGPoint(x: 2, y: frame.minY + 20)
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.affectedByGravity = false


        addChild(ground)

//        let moveLeft = SKAction.moveBy(x: -groundTexture.size().width, y: 0, duration: 5)
//        let moveReset = SKAction.moveBy(x: groundTexture.size().width, y: 0, duration: 0)
//        let moveLoop = SKAction.sequence([moveLeft, moveReset])
//        let moveForever = SKAction.repeatForever(moveLoop)
//
//        ground.run(moveForever)
        
  
    }
    
    func loadCharacter(_ player: SKSpriteNode) {
        
        let startPointX = frame.midX - frame.width/2 + player.size.width/2
        let startPointY = frame.midY - frame.height/2 + player.size.height + 100
        
        player.size = CGSize(width: 100.0, height: 100.0)
        player.zPosition = 1
        player.name = "cutter"
        player.position = CGPoint(x: startPointX, y: startPointY)
        
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.applyTorque(50)
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.categoryBitMask = woodCutterCategory
        player.physicsBody?.collisionBitMask = self.treeSpriteCategory
        addChild(player)
    }
    
    func loadTree(tree: SKSpriteNode) {
        
        tree.zPosition = 4
        tree.name = "tree"
        tree.position = CGPoint(x: CGFloat.random(in: frame.midX ..< frame.maxX), y:frame.midY)
        tree.physicsBody = SKPhysicsBody(rectangleOf: tree.size)
        tree.physicsBody?.categoryBitMask = treeSpriteCategory
        tree.physicsBody?.contactTestBitMask = woodCutterCategory
        addChild(tree)
    }

}


extension UIColor {
    static let myColor = #colorLiteral(red: 0, green: 0.5713948011, blue: 0.8833462, alpha: 1)
}

enum Key: String {
    case Attack, Run, Jump
}
