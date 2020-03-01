//
//  GameScene.swift
//  MyFirstGame
//
//  Created by Vinicius Mesquita on 22/02/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let wooCutterCategory: UInt32 = 0x1 << 0
    let treeSpriteCategory: UInt32 = 0x1 << 1
    
    var woodCutterSprite = SKSpriteNode(imageNamed: "tile001")
    var woodCutterFrame = [SKTexture]()
    var woodCutterFrameAttack = [SKTexture]()
    
    
    let bgSprite = SKSpriteNode(imageNamed: "background")
    let groundSprite = SKSpriteNode(color: UIColor.green, size: CGSize(width: 50, height: 50))
    let treeSprite = SKSpriteNode(color: UIColor.green, size: CGSize(width: 30, height: 100))
    let buttonSprite = SKSpriteNode(color: UIColor.red, size: CGSize(width: 30, height: 30))
    
    
    override func didMove(to view: SKView) {
        scene?.backgroundColor = .myColor
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        
        // character
        createCharacter(character: woodCutterSprite, frame: frame)
        woodCutterSprite.physicsBody?.collisionBitMask = self.treeSpriteCategory
        addChild(woodCutterSprite)
        
        // background
        createBackground(background: bgSprite, floor: groundSprite, frame: frame)
        bgSprite.addChild(groundSprite)
        addChild(bgSprite)
        
        // others elements in scenario
        createTree(tree: treeSprite, frame: frame)
        treeSprite.physicsBody?.categoryBitMask = treeSpriteCategory
        addChild(treeSprite)
    
        
        // button Sprite
        buttonSprite.zPosition = 5
        buttonSprite.position = CGPoint(x: frame.midX , y:frame.midY)
        buttonSprite.action(forKey: Key.Run.rawValue)
        addChild(buttonSprite)
    
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
        
        let runMove = SKAction.move(to: changePosition(sprite: woodCutterSprite, by: woodCutterSprite.position), duration: 15.0)
        
        let jumpMove = SKAction.move(to: jump(sprite: woodCutterSprite), duration: 0.1)
        
        let backgroundMove = SKAction.move(to: changePositionBack(sprite: bgSprite, by: bgSprite.position), duration: 100.0)
       

        if woodCutterSprite.frame.intersects(treeSprite.frame) {
            if let _ = woodCutterSprite.action(forKey: Key.Attack.rawValue) {
              print("intersects !!!!!")
            } else {
                woodCutterSprite.run(SKAction.animate(with: self.woodCutterFrameAttack, timePerFrame: 0.1), withKey: "Attack")
                treeSprite.removeFromParent()
            }
        }


        if let _ = woodCutterSprite.action(forKey: Key.Run.rawValue) {
            if !woodCutterSprite.frame.intersects(treeSprite.frame) {
                woodCutterSprite.removeAction(forKey: Key.Run.rawValue)
                woodCutterSprite.run(jumpMove)
            }
        } else {
            woodCutterSprite.run(SKAction.group([SKAction.repeatForever(runAnimate), SKAction.repeatForever(runMove)]), withKey: Key.Run.rawValue)

            // bgSprite.run(SKAction.repeatForever(backgroundMove))
        }
    }
    
    func checkCollision() {
        enumerateChildNodes(withName: "cutter") { node, _ in
            let cutter = node as! SKSpriteNode
            print(self.treeSprite.frame)
            if cutter.frame.intersects(self.treeSprite.frame) {
              if let _ = cutter.action(forKey: Key.Run.rawValue) {
                    print("intersects !!!!!")
                    cutter.removeAction(forKey: Key.Run.rawValue)
                self.treeSprite.removeFromParent()
                self.treeSprite.physicsBody = SKPhysicsBody()
                
                } else {
                cutter.removeAction(forKey: Key.Run.rawValue)
                //cutter.run(SKAction.animate(with: self.woodCutterFrameAttack, timePerFrame: 0.1))
    
                self.buttonSprite.color = .green
                }
            }
        }
    }
    
    override func didEvaluateActions() {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    
}


extension UIColor {
    static let myColor = #colorLiteral(red: 0, green: 0.5713948011, blue: 0.8833462, alpha: 1)
}


func changePosition(sprite: SKSpriteNode, by: CGPoint) -> CGPoint {
    let newPosition = CGPoint(x: by.x*15, y: by.y)
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

func createCharacter(character: SKSpriteNode, frame: CGRect) {
    character.size = CGSize(width: 100.0, height: 100.0)
    character.zPosition = 3
    character.name = "cutter"
    character.position = CGPoint(x: frame.midX - frame.width/2 + character.size.width/2, y:frame.midY - frame.height/2 + character.size.height)
    
    character.physicsBody = SKPhysicsBody(rectangleOf: character.size)
    character.physicsBody?.allowsRotation = false
    
}

func createBackground(background: SKSpriteNode, floor: SKSpriteNode, frame: CGRect){
    
    background.zPosition = 2
    background.size = CGSize(width: frame.size.width, height: frame.size.height)
    background.position = CGPoint(x: frame.midX , y:frame.midY)
    
    
    floor.zPosition = 1
    floor.size = CGSize(width: frame.size.width - 5, height: 20)
    floor.position = CGPoint(x: 0, y: -180)
    floor.physicsBody = SKPhysicsBody(rectangleOf: floor.size)
    floor.physicsBody?.affectedByGravity = false
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
