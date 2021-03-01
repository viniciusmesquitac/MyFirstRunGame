//
//  GameScene+Buttons.swift
//  MyFirstGame
//
//  Created by Vinicius Mesquita on 08/07/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func setupButtons() {
        
        attackButton.setAction {
            
            // verify if attack animation is running :D
            if let _ = self.character.action(forKey: PlayerActions.attack.rawValue) {
                
            } else {
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
        
        
        
        padLeft.setAction {
            
            if let _ = self.character.action(forKey: PlayerActions.run.rawValue) {
                self.character.removeAllActions()
                self.character.idle()
            } else {
                if self.character.position.y > 91 {
                    
                    var newPosition: CGPoint = .zero
                    var olderPosition: CGPoint = .zero
                    
                    switch self.character.movingTo {
                    case .left:
                        olderPosition = CGPoint(x: self.position.x - 20, y: self.position.y)
                        newPosition = CGPoint(x: self.position.x - 20, y: self.position.y *  1.7)
                    case .right:
                        olderPosition = CGPoint(x: self.position.x * 1.1, y: self.position.y)
                        newPosition = CGPoint(x: self.position.x * 1.1, y: self.position.y * 1.7)
                        
                    case .none:
                        print("opa")
                    }
                    
                    let jumpMove = SKAction.move(to: newPosition, duration: 0.3)
                    let jumpMoveBack = SKAction.move(to: olderPosition, duration: 0.3)
                    
                    let jumpMoveAction = SKAction.sequence([jumpMove, jumpMoveBack])
                    
                    self.character.move()
                }
                self.character.run(direction: .left)
            }
            
        }
        
        padRight.setAction {
            if let _ = self.character.action(forKey: PlayerActions.run.rawValue) {
                self.character.removeAllActions()
                self.character.idle()
            } else {
                self.character.run(direction: .right)
            }
        }
        
        
        jumpButton.setAction {
            if let _ = self.character.action(forKey: PlayerActions.run.rawValue) {
                self.character.removeAllActions()
                self.character.jump()
                self.character.idle()
            }
            self.character.jump()
        }
        
    }
    
}
