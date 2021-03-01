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
                // If it is running, just wait.
            } else {
                self.character.removeAllActions()
                self.character.idle()
                self.character.attack(repeatForever: false)
                
                self.elements.forEach { element in
                    
                    // Create Tree Logic
                    if let tree = element as? Tree {
                        if self.character.frame.intersects(tree.frame) {
                            tree.life -= 1
                        }
                    }
                    
                    /* Add more elements Logic here */
                }
            }
        }

        padLeft.setAction {
            
            if let _ = self.character.action(forKey: PlayerActions.run.rawValue) {
                self.character.removeAllActions()
                self.character.idle()
            } else {
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
