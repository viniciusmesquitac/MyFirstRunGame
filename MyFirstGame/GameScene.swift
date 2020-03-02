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
    
    var woodCutterSprite = SKSpriteNode(imageNamed: "tile001")
    var woodCutterFrame = [SKTexture]()
    var woodCutterFrameAttack = [SKTexture]()
    
    
    let bgSprite = SKSpriteNode(imageNamed: "background")
    let groundSprite = SKSpriteNode(color: UIColor.green, size: CGSize(width: 50, height: 50))
    let treeSprite = SKSpriteNode(color: UIColor.green, size: CGSize(width: 30, height: 100))
    
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        scene?.backgroundColor = .myColor
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        
        // character
        createCharacter()
        
        
        // background
        //createBackground()
        createGround()
        
        // others elements in scenario
        createTree(tree: treeSprite, frame: frame)
        treeSprite.physicsBody?.categoryBitMask = treeSpriteCategory
        treeSprite.physicsBody?.contactTestBitMask = woodCutterCategory
        addChild(treeSprite)
    
    
        let textureAtlas = SKTextureAtlas(named: "SpritesWoodCutter")

        for index in 0..<textureAtlas.textureNames.count {
            let textureName = "tile00" + String(index)
            woodCutterFrame.append(textureAtlas.textureNamed(textureName))

        }

        let textureAtlasAttack = SKTextureAtlas(named: "SpritesAttack")

        for index in 0..<textureAtlasAttack.textureNames.count {
            let textureName = "attack" + String(index)
            woodCutterFrameAttack.append(textureAtlasAttack.textureNamed(textureName))

        }
    
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let runAnimate = SKAction.animate(with: woodCutterFrame, timePerFrame: 0.1)
        
        let runMove = SKAction.move(to: changePosition(sprite: woodCutterSprite), duration: 15.0)
        
        let jumpMove = SKAction.move(to: jump(sprite: woodCutterSprite), duration: 0.1)
        
        let backgroundMove = SKAction.move(to: changePositionBack(sprite: bgSprite, by: bgSprite.position), duration: 100.0)
        
        
        if let _ = woodCutterSprite.action(forKey: "Run") {
            woodCutterSprite.removeAllActions()
        } else {
            if !woodCutterSprite.frame.intersects(self.treeSprite.frame) {
                let runActions = [SKAction.repeatForever(runAnimate), SKAction.repeatForever(runMove)]
                let runGroupAnimate = SKAction.group(runActions)
                woodCutterSprite.run(runGroupAnimate, withKey: Key.Run.rawValue)
            }
        }
        
        if let _ = woodCutterSprite.action(forKey: "Attack") {
            woodCutterSprite.removeAllActions()
            let runActions = [SKAction.repeatForever(runAnimate), SKAction.repeatForever(runMove)]
            let runGroupAnimate = SKAction.group(runActions)
            woodCutterSprite.run(runGroupAnimate, withKey: Key.Run.rawValue)
        } else {
            print("intersects")
        }
        
        
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collision == woodCutterCategory | treeSpriteCategory {
            print("this colide")
            
            self.woodCutterSprite.removeAllActions()
            self.woodCutterSprite.run(SKAction.repeatForever(SKAction.animate(with: self.woodCutterFrameAttack, timePerFrame: 0.1)), withKey: "Attack")
            self.treeSprite.removeFromParent()
            self.woodCutterSprite.position = CGPoint(x: self.woodCutterSprite.position.x - 20, y: self.woodCutterSprite.position.y)
        }
    }
    
    
    override func didEvaluateActions() {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    
    func createBackground(){
        
        let backgroundTexture = SKTexture(imageNamed: "background")
        
        for i in 0...1 {
            let background = SKSpriteNode(texture: backgroundTexture)
            background.zPosition = 2
            background.anchorPoint = CGPoint.zero
            background.size = CGSize(width: frame.size.width, height: frame.size.height)
            background.position = CGPoint(x: (backgroundTexture.size().width * CGFloat(i)) - CGFloat(1 * i), y: 0)
            addChild(background)
        }
        
    }
    
    func createGround() {
        
        let groundTexture = SKTexture(imageNamed: "ground")
        
        
        
            let ground = SKSpriteNode(texture: groundTexture)
            ground.size = CGSize(width: frame.width - 10, height: 50)
            ground.zPosition = 3
//            ground.anchorPoint = CGPoint.zero
            ground.position = CGPoint(x: 2, y: frame.minY + 20)
            ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
            ground.physicsBody?.affectedByGravity = false
            //ground.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)

            addChild(ground)
//
//            let moveLeft = SKAction.moveBy(x: -groundTexture.size().width, y: 0, duration: 5)
//            let moveReset = SKAction.moveBy(x: groundTexture.size().width, y: 0, duration: 0)
//            let moveLoop = SKAction.sequence([moveLeft, moveReset])
//            let moveForever = SKAction.repeatForever(moveLoop)
//
//            ground.run(moveForever)
        
  
    }
    
    func createCharacter() {
        woodCutterSprite.size = CGSize(width: 100.0, height: 100.0)
        woodCutterSprite.zPosition = 1
        woodCutterSprite.name = "cutter"
        woodCutterSprite.position = CGPoint(x: frame.midX - frame.width/2 + woodCutterSprite.size.width/2 , y:frame.midY - frame.height/2 + woodCutterSprite.size.height + 100)
        
        woodCutterSprite.physicsBody = SKPhysicsBody(rectangleOf: woodCutterSprite.size)
        woodCutterSprite.physicsBody?.applyTorque(50)
        woodCutterSprite.physicsBody?.allowsRotation = false
        woodCutterSprite.physicsBody?.categoryBitMask = woodCutterCategory
        woodCutterSprite.physicsBody?.collisionBitMask = self.treeSpriteCategory
        addChild(woodCutterSprite)
    }

    
}


extension UIColor {
    static let myColor = #colorLiteral(red: 0, green: 0.5713948011, blue: 0.8833462, alpha: 1)
}




func changePosition(sprite: SKSpriteNode) -> CGPoint {
    let newPosition = CGPoint(x: sprite.position.x*15, y: sprite.position.y)
    return newPosition
}

func jump(sprite: SKSpriteNode) -> CGPoint {
    let newPosition = CGPoint(x: sprite.position.x*1.6, y: sprite.position.y * 5)
    return newPosition
}

func changePositionBack(sprite: SKSpriteNode, by: CGPoint) -> CGPoint {
    let newPosition = CGPoint(x: by.x * -15, y: by.y)
    return newPosition
}






func createTree(tree: SKSpriteNode, frame: CGRect){
    tree.zPosition = 4
    tree.name = "tree"
    tree.position = CGPoint(x: frame.midX , y:frame.midY)
    tree.physicsBody = SKPhysicsBody(rectangleOf: tree.size)
}


enum Key: String {
    case Attack, Run, Jump
}
